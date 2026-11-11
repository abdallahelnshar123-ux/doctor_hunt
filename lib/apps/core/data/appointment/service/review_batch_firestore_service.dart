import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment_dto.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/mapper/rating_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/doctor_dto.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReviewBatchFirestoreService {
  final FirebaseFirestore _firestore;

  ReviewBatchFirestoreService(this._firestore);

  Future<void> addReviewAndUpdateAppointment({
    required DoctorDto updatedDoctorDto,
    required AppointmentDto updatedAppointmentDto,
  }) async {
    try {
      final batch = _firestore.batch();

      final ratingData = {
        FirestoreConstants.rating: updatedDoctorDto.rating.toDto().toFireStore(),
        FirestoreConstants.updatedAt: FieldValue.serverTimestamp(),
      };

      final userDoc = await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(updatedDoctorDto.id)
          .get();
      if (userDoc.exists) {
        final userDoctorRef = _firestore
            .collection(FirestoreConstants.usersCollection)
            .doc(updatedDoctorDto.id);
        batch.update(userDoctorRef, ratingData);

        if (updatedAppointmentDto.review != null) {
          final reviewRef = userDoctorRef
              .collection(FirestoreConstants.reviews)
              .doc(updatedAppointmentDto.id);
          batch.set(reviewRef, updatedAppointmentDto.review!.toFireStore());
        }
      }

      final doctorDoc = await _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(updatedDoctorDto.id)
          .get();
      if (doctorDoc.exists) {
        final doctorRef = _firestore
            .collection(FirestoreConstants.doctorsCollection)
            .doc(updatedDoctorDto.id);
        batch.update(doctorRef, ratingData);

        if (updatedAppointmentDto.review != null) {
          final reviewRef = doctorRef
              .collection(FirestoreConstants.reviews)
              .doc(updatedAppointmentDto.id);
          batch.set(reviewRef, updatedAppointmentDto.review!.toFireStore());
        }
      }

      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(updatedAppointmentDto.id);
      batch.set(appointmentRef, updatedAppointmentDto.toFireStore());

      await batch.commit();
    } catch (e) {
      throw ServerException(
        message: t.errors.failedToUpdateAppointmentStatus(E: e.toString()),
      );
    }
  }
}
