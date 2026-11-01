import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/patient_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/user_roles.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdminPatientsRemoteDataSource {
  final FirebaseFirestore _firestore;

  AdminPatientsRemoteDataSource(this._firestore);

  Future<List<PatientDto>> getPatients() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreConstants.usersCollection)
          .where(FirestoreConstants.role, isEqualTo: UserRoles.patient.name)
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data[FirestoreConstants.id] = doc.id;
        return PatientDto.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
