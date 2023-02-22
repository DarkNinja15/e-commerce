// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:user/models/user_model.dart';
import 'package:user/screens/Intro-Screens/login_page.dart';
import 'package:user/shared/shared_properties.dart';
import 'Database_Service.dart';
import 'Shared_Pref.dart';

class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(content),
    );
  }

  // getting user details
  // Future<UserModel> getUserDetails() async {
  //   String? uid  = FirebaseAuth.instance.currentUser?.uid;
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .get();
  //   return UserModel.fromSnap(snap);
  // }

  // sign in with google
  static Future<bool?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount;

      try {
        googleSignInAccount = await googleSignIn.signIn();
      } on PlatformException catch (err) {
        // Mobile Network check...
        String x = err.toString();
        // print(x);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Something went wrong. Try again ! $x'),
          ),
        );
        return false;
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'The account already exists with a different credential',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }
    }

    if (user != null) {
      await HelperFunctions.saveUserLoggedInStatus(true);
      await DatabaseService(uid: user.uid).savingUserData();
      return true;
    }
    return null;
  }

  // google sign out
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      await HelperFunctions.saveUserLoggedInStatus(false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  // sign in with email and password
  Future<String> signinwithemailandpassword(
    String email,
    String password,
    String userName,
    String phoneNo,
    String address,
  ) async {
    String res = "Some error Occurred.";
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await HelperFunctions.saveUserLoggedInStatus(true);

      String uid = credential.user!.uid;
      UserModel userModel = UserModel(
        userUid: uid,
        userName: userName,
        phoneNo: phoneNo,
        email: email,
        address: address,
        cart: [],
        orders: [],
        profilePicUrl:
            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        wishlist: [],
      );

      // adding user to firebase
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
            userModel.toMap(),
          );
      res = 'Success';
      return res;
    } on FirebaseAuthException catch (error) {
      // print(error.code);
      if (error.code == 'email-already-in-use') {
        return 'Email already in use';
      } else if (error.code == 'invalid-email') {
        return 'Email Invalid';
      } else if (error.code == 'weak-password') {
        return 'Password too weak';
      }
      return 'Some error Occured';
    } catch (e) {
      return res;
    }
  }

  // login user with email and password
  Future<String> logmein(
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please enter all the fields';
    }
    String res = 'Some error Occurred.';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await HelperFunctions.saveUserLoggedInStatus(true);

      res = 'Success';
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

  // forgot password
  Future<String> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      Shared().snackbar(
        'An email with a link for reseting the password has been sent to $email\nPlease check your spam box if you have not received the email.',
        context,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
