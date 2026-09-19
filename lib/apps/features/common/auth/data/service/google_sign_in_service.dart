import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleSignInService {
  final GoogleSignIn _googleSignIn;

  GoogleSignInService(this._googleSignIn);

  Future<AuthCredential> getGoogleCredential() async {
    await _googleSignIn.initialize(
      clientId:
          '881075334135-ov74682hu4g63rqjpq4d17qol1oam6aq.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleAccount = await _googleSignIn
        .authenticate();

    final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

    return GoogleAuthProvider.credential(idToken: googleAuth.idToken);
  }
}
