import 'dart:io';

import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/exceptions/app_exceptions.dart';
import '../../mappers/auth_user_dto_mapper.dart';
import '../../models/user_dto/auth_user_dto.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService(this._firebaseAuth, this._googleSignIn);

  Future<AuthCredential> _getGoogleCredential() async {
    await _googleSignIn.initialize(
      clientId:
          '881075334135-ov74682hu4g63rqjpq4d17qol1oam6aq.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleAccount = await _googleSignIn
        .authenticate();

    final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

    return GoogleAuthProvider.credential(idToken: googleAuth.idToken);
  }

  Future<AuthUserDto> continueWithGoogle() async {
    try {
      final credential = await _getGoogleCredential();

      var userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      if (e.code == t.eCodes.webUserInteractionFailed ||
          e.code == t.eCodes.cancelled) {
        throw const CancelledByUserException();
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled') {
        throw const CancelledByUserException();
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<AuthUserDto> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      if (e.code == t.eCodes.invalidCredential) {
        throw ServerException(message: t.errors.emailOrPasswordIsIncorrect);
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      if (e.code == t.eCodes.emailAlreadyInUse) {
        throw ServerException(
          message: t.errors.emailAddressAlreadyInUseByAnotherAccount,
        );
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<AuthUserDto> reAuthenticate({required String password}) async {
    try {
      final user = _firebaseAuth.currentUser;

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );

      var userCredential = await user.reauthenticateWithCredential(credential);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled') {
        throw const CancelledByUserException();
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<AuthUserDto> reAuthenticateWithGoogle() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw UnauthorizedException(message: t.errors.userNotAuthenticated);
      }

      final credential = await _getGoogleCredential();

      var userCredential = await user.reauthenticateWithCredential(credential);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled') {
        throw const CancelledByUserException();
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.serverError);
    } catch (e) {
      if (e is PlatformException &&
          (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled')) {
        throw const CancelledByUserException();
      }
      if (e.toString().contains('GoogleSignInExceptionCode.canceled') ||
          e.toString().contains('sign_in_canceled') ||
          e.toString().contains('Cancelled by user')) {
        throw const CancelledByUserException();
      }
      throw UnexpectedException(message: e.toString());
    }
  }
}
