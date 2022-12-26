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

  // sign out of the app
  Future<String> signoutoftheapp() async {
    String res = "Some error Occured";
    try {
      await _auth.signOut();
      res = "Success";
      return res;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      return res;
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  // forgot password
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
