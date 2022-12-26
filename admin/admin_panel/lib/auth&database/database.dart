import 'package:admin_panel/auth&database/storage_methods.dart';
import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/models/seller_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Database {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // add a product to database
  Future<String> addProduct(
    String name,
    String desc,
    String price,
    Uint8List? image,
    int quantity,
    double discount,
    int discountProductLimit,
    String sellerUid,
  ) async {
    String res = "Some error Occured";
    try {
      String prodId = const Uuid().v1();
      final photoUrl = await StorageMethods()
          .uploadImagetoStorage('products', image!, prodId);

      Product product = Product(
        id: prodId,
        photoUrl: photoUrl,
        name: name,
        desc: desc,
        price: double.parse(price),
        quantity: quantity,
        discount: discount,
        discountProductLimit: discountProductLimit,
        sellerUid: sellerUid,
      );
      firestore.collection('products').doc(prodId).set(
            product.toMap(),
          );
      res = "Success";
      return res;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      return "Could not process";
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  // add a seller to database
  Future<String> addSeller(
    String name,
    String phoneNum,
    String address,
    String email,
    String password,
  ) async {
    FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: Firebase.app().options,
    );
    // creat a seller
    String res = "Some error Occured";
    try {
      UserCredential credential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      model.Seller seller = model.Seller(
        name: name,
        phoneNum: phoneNum,
        address: address,
        email: email,
      );

      // add seller to firestore
      await firestore.collection('sellers').doc(credential.user!.uid).set(
            seller.toMap(),
          );
      res = "Success";
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
}
