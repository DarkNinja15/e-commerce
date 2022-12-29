// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: prefer_typing_uninitialized_variables
var userData;

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future savingUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    if (snap.data() == null) {
      await userCollection.doc(uid).set({
        "user_name": 0,
        "phone_no": 0,
        "address": 0,
        "email": 0,
      });
    }
  }

  Future getUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    var temp = snap.data() as Map;
    userData = temp;
  }
}
