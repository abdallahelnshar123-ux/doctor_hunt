import 'package:doctor_hunt/apps/core/mapper/auth_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/google_sign_in_service.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../dto/user_dto/auth_user_dto.dart';

@lazySingleton
class FirebaseAuthService {
  final GoogleSignInService _googleSignInService;
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth, this._googleSignInService);

  Future<AuthUserDto> continueWithGoogle() async {
    final credential = await _googleSignInService.getGoogleCredential();

    var userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.toAuthUserDto();
  }

  Future<AuthUserDto> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.toAuthUserDto();
  }

  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.toAuthUserDto();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<AuthUserDto> reAuthenticate({required String password}) async {
    final user = _firebaseAuth.currentUser;

    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );

    var userCredential = await user.reauthenticateWithCredential(credential);
    return userCredential.toAuthUserDto();
  }

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();
  }

  Future<AuthUserDto> reAuthenticateWithGoogle() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw UnauthorizedException(message: t.errors.user_not_authenticated);
    }

    final credential = await _googleSignInService.getGoogleCredential();

    var userCredential = await user.reauthenticateWithCredential(credential);
    return userCredential.toAuthUserDto();
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
