import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/constants/firestore_constants.dart';
import '../../../../../core/data/models/doctor/doctor_dto.dart';
import '../../../../../core/exceptions/app_exceptions.dart';
import '../models/appointment_dto/appointment_dto.dart';

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

      final doctorRef = _firestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(updatedDoctorDto.id);

      batch.update(doctorRef, updatedDoctorDto.toFireStore());

      final appointmentRef = _firestore
          .collection(FirestoreConstants.appointmentsCollection)
          .doc(updatedAppointmentDto.id);

      batch.update(appointmentRef, updatedAppointmentDto.toFireStore());

      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
