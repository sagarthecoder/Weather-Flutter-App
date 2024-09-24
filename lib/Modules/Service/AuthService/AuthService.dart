import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_flutter/Modules/UISections/Oauth/Login/Model/OauthEnums.dart';

final class AuthService {
  AuthService._internal();
  static final AuthService shared = AuthService._internal();
  final _auth = FirebaseAuth.instance;

  Future<void> signupWithEmail(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential _ =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print('credential id token = ${credential.idToken}');
    // final User? user = userCredential.user;
  }
}
