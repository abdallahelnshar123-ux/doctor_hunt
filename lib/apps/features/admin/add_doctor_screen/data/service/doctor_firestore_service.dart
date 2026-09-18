import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor_dto/doctor_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/firestore_constants.dart';
import '../../../../../core/exceptions/app_exceptions.dart';

@lazySingleton
class DoctorFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  DoctorFirestoreService(this._firebaseFirestore);

  /// ==========================   doctors    ==============================
  CollectionReference<DoctorDto> _getDoctorsCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.doctorsCollection)
        .withConverter<DoctorDto>(
          fromFirestore: (snapshot, options) =>
              DoctorDto.fromFireStore(snapshot.data()!),
          toFirestore: (doctor, options) => doctor.toFireStore(),
        );
  }

  Future<void> addDoctor(DoctorDto doctor) {
    try {
      var doc = _getDoctorsCollection().doc();
      return doc.set(doctor.copyWith(id: doc.id));
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Stream<List<DoctorDto>> getDoctorsStreamForAdmin({required String adminId}) {
    return _getDoctorsCollection()
        .where(FirestoreConstants.adminId, isEqualTo: adminId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .handleError((error) {
          switch (error) {
            case FirebaseException _:
              throw ServerException(message: error.message ?? 'server_error');
            case SocketException _:
              throw NetworkException(message: 'no_internet');
            default:
              throw UnexpectedException(message: error.toString());
          }
        });
  }

  Stream<List<DoctorDto>> getDoctorsStreamForPatient() {
    return _getDoctorsCollection()
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .handleError((error) {
          switch (error) {
            case FirebaseException _:
              throw ServerException(message: error.message ?? 'server_error');
            case SocketException _:
              throw NetworkException(message: 'no_internet');
            default:
              throw UnexpectedException(message: error.toString());
          }
        });
  }
}
