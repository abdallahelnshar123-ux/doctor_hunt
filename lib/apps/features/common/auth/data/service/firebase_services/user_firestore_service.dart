import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../../../../../../core/exceptions/app_exceptions.dart';
import '../../models/user_dto/my_user_dto.dart';

@lazySingleton
class UserFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  UserFirestoreService(this._firebaseFirestore);

  /// ==========================   users     ==============================
  CollectionReference<MyUserDto> _getUsersCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .withConverter<MyUserDto>(
          fromFirestore: (snapshot, options) =>
              MyUserDto.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  Future<void> addUser(MyUserDto myUser) {
    try {
      return _getUsersCollection().doc(myUser.id).set(myUser);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<MyUserDto?> getUser(String uId) async {
    try {
      var documentSnapshot = await _getUsersCollection().doc(uId).get();
      return documentSnapshot.data();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> updateUser(MyUserDto user) async {
    try {
      var querySnapshot = _getUsersCollection().doc(user.id);
      await querySnapshot.update(user.toFireStore());
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> deleteUser(String uId) async {
    try {
      await _getUsersCollection().doc(uId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
