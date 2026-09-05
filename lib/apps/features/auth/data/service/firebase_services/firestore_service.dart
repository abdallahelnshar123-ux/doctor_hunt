import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/auth/data/models/admin_dto/my_admin_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/firestore_constants.dart';
import '../../models/user_dto/my_user_dto.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreService(this._firebaseFirestore);


  /// ==========================   users     ==============================
  CollectionReference<MyUserDto> getUsersCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .withConverter<MyUserDto>(
      fromFirestore: (snapshot, options) =>
          MyUserDto.fromFireStore(snapshot.data()!),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  Future<void> addUserToFireStore(MyUserDto myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  Future<MyUserDto?> getUserFromFireStore(String uId) async {
    var documentSnapshot = await getUsersCollection().doc(uId).get();
    return documentSnapshot.data();
  }

  Future<void> updateUserDataToFirestore(MyUserDto user) async {
    var querySnapshot = getUsersCollection().doc(user.id);
    await querySnapshot.update(user.toFireStore());
  }

  Future<void> deleteUserFromFirestore(String uId) async {
    await getUsersCollection().doc(uId).delete();
  }


  /// ==============================  admins   =====================================

  CollectionReference<MyAdminDto> getAdminsCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.adminsCollection)
        .withConverter<MyAdminDto>(
      fromFirestore: (snapshot, options) =>
          MyAdminDto.fromFireStore(snapshot.data()!),
      toFirestore: (admin, options) => admin.toFireStore(),
    );
  }
  Future<MyAdminDto?> getAdminFromFireStore(String aId) async {
    var documentSnapshot = await getAdminsCollection().doc(aId).get();
    return documentSnapshot.data();
  }

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
