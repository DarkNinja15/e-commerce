// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var userData;

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future savingUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    if (snap.data() == null) {
      await userCollection.doc(uid).set({
        "userUid": uid,
        "userName": user?.displayName,
        "phoneNo": user?.phoneNumber,
        "address": " ",
        "email": user?.email,
        "profilePicUrl": user?.photoURL,
        "cart": [],
        "wishlist": [],
        "orders": [],
      });
    }
  }

  Future getUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    var temp = snap.data() as Map;
    userData = temp;
  }
}
