import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment_dto.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/review_dto.dart';
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

  Future<List<ReviewDto>> getDoctorReviews(String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(doctorId)
          .collection(FirestoreConstants.reviews)
          .get();
      return snapshot.docs
          .map((doc) => ReviewDto.fromFireStore(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(
        message: t.errors.someThingWentWrong,
      );
    }
  }
}
