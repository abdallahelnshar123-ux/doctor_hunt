import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/constants/firestore_constants.dart';
import '../../../../../core/exceptions/app_exceptions.dart';

@lazySingleton
class DoctorFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  DoctorFirestoreService(this._firebaseFirestore);

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
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
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
              throw ServerException(
                message: error.message ?? t.errors.server_error,
              );
            case SocketException _:
              throw NetworkException(message: t.errors.no_internet);
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
              throw ServerException(
                message: error.message ?? t.errors.server_error,
              );
            case SocketException _:
              throw NetworkException(message: t.errors.no_internet);
            default:
              throw UnexpectedException(message: error.toString());
          }
        });
  }

  // Future<List<DoctorDto>> searchDoctors({
  //   required String adminId,
  //   required String query,
  // }) async {
  //   try {
  //     final snapshot = await _getDoctorsCollection()
  //         .where(FirestoreConstants.adminId, isEqualTo: adminId)
  //         .where(FirestoreConstants.name, arrayContains: query)
  //         .where(FirestoreConstants.specialty, arrayContains: query).get();
  //     final allDoctors = snapshot.docs.map((doc) => doc.data()).toList();
  //     return allDoctors;
  //     // return allDoctors.where((doctor) {
  //     //   final nameMatches = doctor.name.toLowerCase().contains(
  //     //     query.toLowerCase(),
  //     //   );
  //     //   final specialtyMatches = doctor.specialty.name.toLowerCase().contains(
  //     //     query.toLowerCase(),
  //     //   );
  //     //   return nameMatches || specialtyMatches;
  //     // }).toList();
  //   } on FirebaseException catch (e) {
  //     throw ServerException(message: e.message ?? t.errors.server_error);
  //   } on SocketException {
  //     throw NetworkException(message: t.errors.no_internet);
  //   } catch (e) {
  //     throw UnexpectedException(message: e.toString());
  //   }
  // }

  Future<void> updateDoctorActiveStatus({
    required String doctorId,
    required bool active,
  }) async {
    try {
      await _getDoctorsCollection().doc(doctorId).update({
        FirestoreConstants.active: active,
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> updateDoctorDetails(DoctorDto doctor) async {
    try {
      await _getDoctorsCollection().doc(doctor.id).set(doctor);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> deleteDoctor({required String doctorId}) async {
    try {
      await _getDoctorsCollection().doc(doctorId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
