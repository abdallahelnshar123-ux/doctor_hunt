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

  /// ==========================   users     ==============================
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

  // Future<MyUserDto?> getUser(String uId) async {
  //   try {
  //     var documentSnapshot = await _getDoctorsCollection().doc(uId).get();
  //     return documentSnapshot.data();
  //   } on FirebaseException catch (e) {
  //     throw ServerException(message: e.message ?? 'server_error');
  //   } on SocketException {
  //     throw NetworkException(message: 'no_internet');
  //   } catch (e) {
  //     throw UnexpectedException(message: e.toString());
  //   }
  // }
  //
  // Future<void> updateUser(MyUserDto user) async {
  //   try {
  //     var querySnapshot = _getDoctorsCollection().doc(user.id);
  //     await querySnapshot.update(user.toFireStore());
  //   } on FirebaseException catch (e) {
  //     throw ServerException(message: e.message ?? 'server_error');
  //   } on SocketException {
  //     throw NetworkException(message: 'no_internet');
  //   } catch (e) {
  //     throw UnexpectedException(message: e.toString());
  //   }
  // }
  //
  // Future<void> deleteUser(String uId) async {
  //   try {
  //     await _getDoctorsCollection().doc(uId).delete();
  //   } on FirebaseException catch (e) {
  //     throw ServerException(message: e.message ?? 'server_error');
  //   } on SocketException {
  //     throw NetworkException(message: 'no_internet');
  //   } catch (e) {
  //     throw UnexpectedException(message: e.toString());
  //   }
  // }
}
