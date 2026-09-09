import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../../../../../../core/exceptions/app_exceptions.dart';
import '../../models/user_dto/my_user_dto.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreService(this._firebaseFirestore);

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

  // /// ==============================  admins   =====================================
  //
  // CollectionReference<MyAdminDto> getAdminsCollection() {
  //   return _firebaseFirestore
  //       .collection(FirestoreConstants.adminsCollection)
  //       .withConverter<MyAdminDto>(
  //         fromFirestore: (snapshot, options) =>
  //             MyAdminDto.fromFireStore(snapshot.data()!),
  //         toFirestore: (admin, options) => admin.toFireStore(),
  //       );
  // }
  //
  // Future<MyAdminDto?> getAdminFromFireStore(String aId) async {
  //   var documentSnapshot = await getAdminsCollection().doc(aId).get();
  //   return documentSnapshot.data();
  // }

  /// ===============================   Accounts   =============================
  // CollectionReference<PlatformAccountDto> getAccountsCollection(String uId) {
  //   return getUsersCollection()
  //       .doc(uId)
  //       .collection(FirestoreConstants.accountsCollection)
  //       .withConverter<PlatformAccountDto>(
  //     fromFirestore: (snapshot, options) =>
  //         PlatformAccountDto.fromFireStore(snapshot.data()!),
  //     toFirestore: (accountDto, options) => accountDto.toFireStore(),
  //   );
  // }
  //
  // Future<void> addAccount({
  //   required PlatformAccountDto account,
  //   required String uId,
  // }) {
  //   var collection = getAccountsCollection(uId);
  //   var document = collection.doc();
  //   return document.set(account.copyWith(id: document.id));
  // }
  //
  // Future<void> updateAccount({
  //   required PlatformAccountDto account,
  //   required String uId,
  // }) {
  //   return getAccountsCollection(uId).doc(account.id).set(account);
  // }
  //
  // Stream<List<PlatformAccountDto>> getAccountsStream({required String uId}) {
  //   return getAccountsCollection(uId)
  //       .orderBy(FirestoreConstants.createdAt, descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  // }
  //
  // Future<void> deleteAccount({required String uId, required String accountId}) {
  //   return getAccountsCollection(uId).doc(accountId).delete();
  // }
  //
  // Future<PlatformAccountDto?> getAccountById({
  //   required String accountId,
  //   required String uId,
  // }) async {
  //   var documentSnapshot = await getAccountByIdRaw(
  //     uId: uId,
  //     accountId: accountId,
  //   );
  //   return documentSnapshot.data();
  // }
  //
  // Future<DocumentSnapshot<PlatformAccountDto>> getAccountByIdRaw({
  //   required String uId,
  //   required String accountId,
  // }) async {
  //   return await getAccountsCollection(uId).doc(accountId).get();
  // }
  //
  // Future<List<PlatformAccountDto>> getAllAccountsOnce(
  //     {required String uId}) async {
  //   var querySnapshot = await getAccountsCollection(uId).get();
  //   return querySnapshot.docs.map((doc) => doc.data()).toList();
  // }
}
