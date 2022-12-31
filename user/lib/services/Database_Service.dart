// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/models/category_model.dart' as cate;

import '../models/product_model.dart';

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
        "userUid": user?.uid,
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

  Future savechanges(String picUrl, String name, String number, String Address,
      BuildContext ctx) async {
    try {
      await userCollection.doc(uid).update({
        "profilePicUrl": picUrl,
        "userName": name,
        "phoneNo": number,
        "address": Address,
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text(' Changes Saved .. '),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(' Error Occurred . Try again ! '),
        ),
      );
      return false;
    }
  }

  Future getUserData() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    var temp = snap.data() as Map;
    userData = temp;
  }

  // retrieving products from database
  Stream<List<Product>> get products {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => Product(
                id: (documentSnapshot.data()! as Map<String, dynamic>)['id'],
                photoUrl: (documentSnapshot.data()!
                    as Map<String, dynamic>)['photoUrl'],
                name:
                    (documentSnapshot.data()! as Map<String, dynamic>)['name'],
                desc:
                    (documentSnapshot.data()! as Map<String, dynamic>)['desc'],
                price:
                    (documentSnapshot.data()! as Map<String, dynamic>)['price'],
                quantity: (documentSnapshot.data()!
                    as Map<String, dynamic>)['quantity'],
                sellerUid: (documentSnapshot.data()!
                    as Map<String, dynamic>)['sellerUid'],
                category: (documentSnapshot.data()!
                    as Map<String, dynamic>)['category'],
                discount: (documentSnapshot.data()!
                    as Map<String, dynamic>)['discount'],
                discountProductLimit: (documentSnapshot.data()!
                    as Map<String, dynamic>)['discountProductLimit'],
                isPromoted: ((documentSnapshot.data()!
                    as Map<String, dynamic>)['isPromoted']) as bool,
              ),
            )
            .toList());
  }

  // retrieving category from database
  Stream<List<cate.Category>> get category {
    return FirebaseFirestore.instance
        .collection('category')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => cate.Category(
                  catUid: (documentSnapshot.data()!
                      as Map<String, dynamic>)['catUid'],
                  name: (documentSnapshot.data()!
                      as Map<String, dynamic>)['name'],
                  thumbnailPicUrl: (documentSnapshot.data()!
                      as Map<String, dynamic>)['thumbnailPicUrl'],
                  userName: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userName'],
                  userUid: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userUid'],
                ))
            .toList());
  }
}
