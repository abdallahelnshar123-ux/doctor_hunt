import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/firestore_constants.dart';
import '../dto/user_dto/my_user_dto.dart';

@lazySingleton
class UserFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  UserFirestoreService(this._firebaseFirestore);

  CollectionReference<MyUserDto> _getUsersCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .withConverter<MyUserDto>(
          fromFirestore: (snapshot, options) =>
              MyUserDto.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  Future<void> addUser(MyUserDto myUser) async {
    return await _getUsersCollection().doc(myUser.id).set(myUser);
  }

  Future<MyUserDto?> getUser(String uId) async {
    var documentSnapshot = await _getUsersCollection().doc(uId).get();
    return documentSnapshot.data();
  }

  Future<void> updateUser(MyUserDto user) async {
    var querySnapshot = _getUsersCollection().doc(user.id);
    await querySnapshot.update(user.toFireStore());
  }

  Future<void> deleteUser(String uId) async {
    await _getUsersCollection().doc(uId).delete();
  }
}
