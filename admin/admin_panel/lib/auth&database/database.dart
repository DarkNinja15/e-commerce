import 'package:admin_panel/auth&database/storage_methods.dart';
import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/models/seller_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
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
    String category,
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
        category: category,
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
    // create a seller
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

  // update product model
  Future<String> updateSeller(
    String name,
    String desc,
    String price,
    String image,
    int quantity,
    double discount,
    int discountProductLimit,
    Uint8List? newImage,
    Product snap,
  ) async {
    if ((auth.currentUser!.uid) != snap.sellerUid) {
      return "Only the seller to which the products belong can update the products.";
    }
    String res = "Some error Occured";
    try {
      String prodId = snap.id;
      String photoUrl = '';
      if (newImage != null) {
        photoUrl = await StorageMethods()
            .uploadImagetoStorage('products', newImage, prodId);
      }
      Product product = Product(
        id: prodId,
        photoUrl: newImage != null ? photoUrl : image,
        name: name,
        desc: desc,
        price: double.parse(price),
        quantity: quantity,
        discount: discount,
        discountProductLimit: discountProductLimit,
        sellerUid: snap.sellerUid,
        category: snap.category,
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

  // delete product from database
  Future<String> deleteProduct(String id, String sellerUid) async {
    if (auth.currentUser!.uid != sellerUid) {
      return "Only the seller to which the products belong can delete the products.";
    }
    String res = "Some error Occurred";
    try {
      await firestore.collection('products').doc(id).delete();
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

  // retrieving list of products
  Stream<List<Product>> get products {
    return firestore
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
              ),
            )
            .toList());
  }

  // retrieving list of cattegories for dropdown
  Future<List<String>> get cattegories async {
    try {
      final data = await firestore
          .collection('cattegories')
          .doc('AQrjPBBZ6hbdodDId8wN')
          .get();
      List<String> cat = [];
      for (var i = 0; i < data['listCat'].length; i++) {
        cat.add(data['listCat'][i]);
      }
      return cat;
    } catch (e) {
      // print(e.toString());
      return [];
    }
  }

  // delete category
  Future<String> delCat(String category, BuildContext context) async {
    String res = "Some error Occurred";
    try {
      List<String> cats = Provider.of<List<String>>(context, listen: false);
      cats.remove(category);
      await firestore
          .collection('cattegories')
          .doc('AQrjPBBZ6hbdodDId8wN')
          .set({
        'listCat': cats,
      });
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

  // add category
  Future<String> addCat(String category, BuildContext context) async {
    String res = "Some error Occurred";
    try {
      List<String> cats = Provider.of<List<String>>(context, listen: false);
      if (cats.contains(category)) {
        return 'Category "$category" is already present in the list.';
      }
      cats.add(category);
      await firestore
          .collection('cattegories')
          .doc('AQrjPBBZ6hbdodDId8wN')
          .set({
        'listCat': cats,
      });
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

  // delete order from allorders
  Future<String> deleteOrder(String id) async {
    // print(id);
    if (auth.currentUser!.uid != 'ELO4z0WvXLgHgHSlVuagYBrunXK2') {
      return 'Only "MyBhrmar" has option to decide this.';
    }
    String res = "Some error Occurred";
    try {
      await firestore.collection('allorders').doc(id).delete();
      await firestore.collection('userOrders').doc(id).update({
        'status': 'delivered',
      });
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
}
