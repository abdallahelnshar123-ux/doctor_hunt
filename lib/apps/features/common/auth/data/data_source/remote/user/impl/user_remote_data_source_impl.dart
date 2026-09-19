import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/user_firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../generated/translations.g.dart';
import '../../../../../../../../core/exceptions/app_exceptions.dart';
import '../../../../dto/user_dto/my_user_dto.dart';
import '../user_remote_data_source.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserFirestoreService _userFirestoreService;

  UserRemoteDataSourceImpl(this._userFirestoreService);

  @override
  Future<void> addUser(MyUserDto myUser) async {
    try {
      return await _userFirestoreService.addUser(myUser);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<MyUserDto?> getUser(String uId) async {
    try {
      return await _userFirestoreService.getUser(uId);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> updateUser(MyUserDto user) async {
    try {
      return await _userFirestoreService.updateUser(user);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> deleteUser(String uId) async {
    try {
      return await _userFirestoreService.deleteUser(uId);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
