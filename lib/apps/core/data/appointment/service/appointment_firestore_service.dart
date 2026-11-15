import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment_dto.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentFirestoreService {
  final FirebaseFirestore _firestore;

  AppointmentFirestoreService(this._firestore);

  Future<List<AppointmentDto>> getBookedAppointmentsInRange({
    required String doctorId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .where(
            '${FirestoreConstants.doctor}.${FirestoreConstants.id}',
            isEqualTo: doctorId,
          )
          .where(
            FirestoreConstants.sessionTime,
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .where(
            FirestoreConstants.sessionTime,
            isLessThanOrEqualTo: Timestamp.fromDate(endDate),
          )
          // Fetch upcoming and completed to mark them as unavailable
          .where(
            FirestoreConstants.status,
            whereIn: [
              AppointmentStatus.upcoming.name,
              AppointmentStatus.completed.name,
            ],
          )
          .get();

      return querySnapshot.docs
          .map((doc) => AppointmentDto.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(
        message: t.core.errors.failedToFetchAppointments(E: e.toString()),
      );
    }
  }

  Stream<List<AppointmentDto>> getPatientAppointmentsStream(String patientId) {
    return _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .where(
          '${FirestoreConstants.patient}.${FirestoreConstants.id}',
          isEqualTo: patientId,
        )
        .snapshots()
        .map((snapshot) {
          final appointments = snapshot.docs
              .map((doc) => AppointmentDto.fromJson(doc.data()))
              .toList();
          appointments.sort((a, b) => b.sessionTime.compareTo(a.sessionTime));
          return appointments;
        })
        .handleError((e) {
          throw ServerException(
            message: t.core.errors.failedToFetchAppointments(E: e.toString()),
          );
        });
  }

  Stream<List<AppointmentDto>> getDoctorAppointmentsStream(String doctorId) {
    return _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .where(
          '${FirestoreConstants.doctor}.${FirestoreConstants.id}',
          isEqualTo: doctorId,
        )
        .snapshots()
        .map((snapshot) {
          final appointments = snapshot.docs
              .map((doc) => AppointmentDto.fromJson(doc.data()))
              .toList();
          appointments.sort((a, b) => b.sessionTime.compareTo(a.sessionTime));
          return appointments;
        })
        .handleError((e) {
          throw ServerException(
            message: t.core.errors.failedToFetchAppointments(E: e.toString()),
          );
        });
  }

  Future<void> bookAppointment(AppointmentDto appointmentDto) async {
    try {
      final slotLockId =
          '${appointmentDto.doctor.id}_${appointmentDto.sessionTime.millisecondsSinceEpoch}';
      final slotRef = _firestore
          .collection(FirestoreConstants.doctorSlotsCollection)
          .doc(slotLockId);
      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc();

      await _firestore.runTransaction((transaction) async {
        // 1. Atomic Read
        final slotSnapshot = await transaction.get(slotRef);

        // 2. Atomic Check
        if (slotSnapshot.exists) {
          final isBooked =
              slotSnapshot.data()?[FirestoreConstants.isBooked] as bool? ??
              false;
          if (isBooked) {
            throw SlotAlreadyBookedException();
          }
        }

        // 3. Atomic Dual Write
        final newAppointment = appointmentDto.copyWith(id: appointmentRef.id);

        // a. Lock the slot
        transaction.set(slotRef, {
          FirestoreConstants.isBooked: true,
          FirestoreConstants.appointmentId: appointmentRef.id,
          FirestoreConstants.updatedAt: FieldValue.serverTimestamp(),
        });

        // b. Create appointment record
        transaction.set(appointmentRef, newAppointment.toFireStore());
      });
    } on SlotAlreadyBookedException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: t.core.errors.failedToBookAppointment(E: e.toString()),
      );
    }
  }

  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorId,
    required DateTime sessionTime,
  }) async {
    try {
      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(appointmentId);
      final slotLockId = '${doctorId}_${sessionTime.millisecondsSinceEpoch}';
      final slotRef = _firestore
          .collection(FirestoreConstants.doctorSlotsCollection)
          .doc(slotLockId);

      await _firestore.runTransaction((transaction) async {
        // 1. Update appointment status to cancelled
        transaction.update(appointmentRef, {
          FirestoreConstants.status: AppointmentStatus.cancelled.name,
        });

        // 2. Release slot lock to make it available for booking
        transaction.set(
          slotRef,
          {
            FirestoreConstants.isBooked: false,
            FirestoreConstants.appointmentId: null,
            FirestoreConstants.updatedAt: FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      });
    } catch (e) {
      throw ServerException(
        message: t.core.errors.failedToUpdateAppointmentStatus(E: e.toString()),
      );
    }
  }

  Stream<List<AppointmentDto>> getAdminAppointmentsStream() {
    return _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .snapshots()
        .map((snapshot) {
          final appointments = snapshot.docs
              .map((doc) => AppointmentDto.fromJson(doc.data()))
              .toList();
          appointments.sort((a, b) => b.sessionTime.compareTo(a.sessionTime));
          return appointments;
        })
        .handleError((e) {
          throw ServerException(
            message: t.core.errors.failedToFetchAppointments(E: e.toString()),
          );
        });
  }

  Future<void> updateAppointmentStatus(
    String appointmentId,
    AppointmentStatus status,
  ) async {
    try {
      await _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(appointmentId)
          .update({FirestoreConstants.status: status.name});
    } catch (e) {
      throw ServerException(
        message: t.core.errors.failedToUpdateAppointmentStatus(E: e.toString()),
      );
    }
  }
}
