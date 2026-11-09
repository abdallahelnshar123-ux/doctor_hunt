import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../generated/translations.g.dart';
import '../../../../../../../core/constants/firestore_constants.dart';
import '../../../../../../../core/exceptions/app_exceptions.dart';
import '../../../dto/user/app_user_dto.dart';
import '../../../mappers/auth_user_dto_mapper.dart';
import '../../../models/user_dto/auth_user_dto.dart';
import '../auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseFirestore,
  );

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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  /// ==========================   Firestore Users     ==============================
  CollectionReference<AppUserDto> _getUsersCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .withConverter<AppUserDto>(
          fromFirestore: (snapshot, options) =>
              AppUserDto.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  @override
  Future<void> addUser(AppUserDto appUser) {
    try {
      return _getUsersCollection().doc(appUser.id).set(appUser);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AppUserDto?> getUser(String uId) async {
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

  @override
  Future<void> updateUser(AppUserDto user) async {
    try {
      var querySnapshot = _getUsersCollection().doc(user.id);
      await querySnapshot.update(user.toJson());
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
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
