import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/constants/firestore_constants.dart';
import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../appointments_tab/data/models/appointment/appointment.dart';
import '../../../appointments_tab/data/models/appointment_dto/appointment_dto.dart';

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
        message: t.errors.failed_to_fetch_appointments(E: e.toString()),
      );
    }
  }

  // Future<List<AppointmentDto>> getPatientAppointments(String patientId) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection(FirestoreConstants.appointmentsCollection)
  //         .where(
  //           '${FirestoreConstants.patient}.${FirestoreConstants.id}',
  //           isEqualTo: patientId,
  //         )
  //         .orderBy(FirestoreConstants.sessionTime, descending: true)
  //         .get();
  //
  //     return querySnapshot.docs
  //         .map((doc) => AppointmentDto.fromJson(doc.data()))
  //         .toList();
  //   } catch (e) {
  //     throw ServerException(
  //       message: t.errors.failed_to_fetch_appointments(E: e.toString()),
  //     );
  //   }
  // }

  Stream<List<AppointmentDto>> getPatientAppointmentsStream(
      String patientId) {
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
    }).handleError((e) {
      throw ServerException(
        message: t.errors.failed_to_fetch_appointments(E: e.toString()),
      );
    });
  }

  Future<void> bookAppointment(AppointmentDto appointmentDto) async {
    try {
      final collectionRef = _firestore.collection(
        FirestoreConstants.appointmentsCollection,
      );
      var doc = collectionRef.doc();

      // Set the ID of the document
      appointmentDto = appointmentDto.copyWith(id: doc.id);

      await collectionRef
          .doc(appointmentDto.id)
          .set(appointmentDto.toFireStore());

      // // If ID is empty, let Firestore generate it
      // if (appointmentDto.id.isEmpty) {
      //   final docRef = await collectionRef.add(appointmentDto.toFireStore());
      //   // Update the document with its generated ID inside the document itself
      //   await docRef.update({FirestoreConstants.id: docRef.id});
      // } else {
      //   await collectionRef
      //       .doc(appointmentDto.id)
      //       .set(appointmentDto.toFireStore());
      // }
    } catch (e) {
      throw ServerException(
        message: t.errors.failed_to_book_appointment(E: e.toString()),
      );
    }
  }

  // Future<List<AppointmentDto>> getAdminAppointments(String adminId) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection(FirestoreConstants.appointmentsCollection)
  //         .where(
  //           '${FirestoreConstants.doctor}.${FirestoreConstants.adminId}',
  //           isEqualTo: adminId,
  //         )
  //         .orderBy(FirestoreConstants.sessionTime, descending: true)
  //         .get();
  //
  //     return querySnapshot.docs
  //         .map((doc) => AppointmentDto.fromJson(doc.data()))
  //         .toList();
  //   } catch (e) {
  //     throw ServerException(
  //       message: t.errors.failed_to_fetch_appointments(E: e.toString()),
  //     );
  //   }
  // }

  Stream<List<AppointmentDto>> getAdminAppointmentsStream(String adminId) {
    return _firestore
        .collection(FirestoreConstants.appointmentsCollection)
        .where(
          '${FirestoreConstants.doctor}.${FirestoreConstants.adminId}',
          isEqualTo: adminId,
        )
        .snapshots()
        .map((snapshot) {
      final appointments = snapshot.docs
          .map((doc) => AppointmentDto.fromJson(doc.data()))
          .toList();
      appointments.sort((a, b) => b.sessionTime.compareTo(a.sessionTime));
      return appointments;
    }).handleError((e) {
      throw ServerException(
        message: t.errors.failed_to_fetch_appointments(E: e.toString()),
      );
    });
  }

  Future<void> updateAppointmentStatus(String appointmentId, AppointmentStatus status) async {
    try {
      await _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(appointmentId)
          .update({FirestoreConstants.status: status.name});
    } catch (e) {
      throw ServerException(
        message:t.errors.failed_to_update_appointment_status(E: e.toString()),
      );
    }
  }
}
