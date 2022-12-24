import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;

  // login the admin

  Future<String> logmein({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      // print('email=$email');
      // print('password=$password');
      if (email.isEmpty || password.isEmpty) {
        return 'Please enter all the fields';
      }

      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        res = "Success";
      });
      return res;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return res;
    } catch (e) {
      return res;
    }
  }
}
