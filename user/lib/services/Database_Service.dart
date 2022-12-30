// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: prefer_typing_uninitialized_variables
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
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
        "user_name": user?.displayName,
        "phone_no": user?.phoneNumber,
        "address": " ",
        "email": user?.email,
        "profile_pic_url": user?.photoURL,
        "cart" : [],
        "wishlist" : [],
        "orders" : [],
<<<<<<< Updated upstream
=======
=======
        "user_name": 0,
        "phone_no": 0,
        "address": 0,
        "email": 0,
>>>>>>> 6ba44b46bf83138198c0f6c6fce522a13eccfd52
>>>>>>> Stashed changes
      });
    }
  }

  Future getUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    var temp = snap.data() as Map;
    userData = temp;
  }
}
