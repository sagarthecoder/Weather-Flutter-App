import 'package:firebase_auth/firebase_auth.dart';

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
}
