import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// abstract class MyAuth {
//   Future<void> signIn({
//     required String email,
//     required String password,
//   });

//   Future<void> signUp({
//     required String email,
//     required String password,
//   });

//   Future<void> googleSignIn();

//   Future<void> googleSignOut();

//   Future<void> signOut();
// }

class MyAuth {
  String? emailError;
  String? passwordError;
  String? email;
  bool hasException = false;
  bool canceledGoogleAuth = false;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      hasException = true;
      if (e.code == 'user-not-found') {
        emailError = 'No user found for that email.';
        passwordError = null;
      } else if (e.code == 'wrong-password') {
        emailError = null;
        passwordError = 'Wrong password provided for that user.';
      } else {
        emailError = e.message.toString();
        passwordError = e.message.toString();
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      hasException = true;
      if (e.code == 'email-already-in-use') {
        emailError = 'The account already exists for that email.';
        passwordError = null;
      } else {
        emailError = e.message.toString();
        passwordError = e.message.toString();
      }
    }
  }

  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> googleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      hasException = true;
      emailError = 'Something went wrong, try again later';
    }
    canceledGoogleAuth = _googleSignIn.currentUser == null ? true : false;
    emailError = canceledGoogleAuth == true ? 'Google auth is canceled' : null;

    email =
        canceledGoogleAuth == false ? _googleSignIn.currentUser?.email : null;
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.disconnect();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
