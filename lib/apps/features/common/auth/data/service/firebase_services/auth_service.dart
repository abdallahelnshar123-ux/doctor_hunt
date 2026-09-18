import 'dart:io';

import 'package:doctor_hunt/apps/core/mapper/auth_user_dto_mapper.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/exceptions/app_exceptions.dart';
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

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.no_internet);
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
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<AuthUserDto> reAuthenticateWithGoogle() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw UnauthorizedException(message: t.errors.user_not_authenticated);
      }

      final credential = await _getGoogleCredential();

      var userCredential = await user.reauthenticateWithCredential(credential);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? t.errors.server_error);
    } on SocketException {
      throw NetworkException(message: t.errors.server_error);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
