import 'dart:io';

import 'package:doctor_hunt/apps/features/common/auth/data/data_source/remote/auth/auth_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../generated/translations.g.dart';
import '../../../../../../../../core/exceptions/app_exceptions.dart';
import '../../../../dto/user_dto/auth_user_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;

  AuthRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<AuthUserDto> continueWithGoogle() async {
    try {
      var authUserDto = await _firebaseAuthService.continueWithGoogle();
      return authUserDto;
    } on FirebaseAuthException catch (e) {
      if (e.code == t.e_codes.web_user_interaction_failed ||
          e.code == t.e_codes.cancelled) {
        throw const CancelledByUserException();
      }
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var authUserDto = await _firebaseAuthService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authUserDto;
    } on FirebaseAuthException catch (e) {
      if (e.code == t.e_codes.invalid_credential) {
        throw ServerException(message: t.errors.email_or_password_is_incorrect);
      }
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var authUserDto = await _firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authUserDto;
    } on FirebaseAuthException catch (e) {
      if (e.code == t.e_codes.email_already_in_use) {
        throw ServerException(
          message: t.errors.email_address_already_in_use_by_another_account,
        );
      }
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuthService.logout();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> reAuthenticate({required String password}) async {
    try {
      final authUserDto = await _firebaseAuthService.reAuthenticate(
        password: password,
      );

      return authUserDto;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _firebaseAuthService.deleteAccount();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> reAuthenticateWithGoogle() async {
    try {
      return await _firebaseAuthService.reAuthenticateWithGoogle();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuthService.resetPassword(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
