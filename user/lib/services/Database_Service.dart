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
        "user_name": user?.displayName,
        "phone_no": user?.phoneNumber,
        "address": " ",
        "email": user?.email,
        "profile_pic_url": user?.photoURL,
        "cart" : [],
        "wishlist" : [],
        "orders" : [],
      });
    }
  }

  Future getUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    var temp = snap.data() as Map;
    userData = temp;
  }
}
