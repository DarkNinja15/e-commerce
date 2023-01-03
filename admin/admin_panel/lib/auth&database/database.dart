import 'dart:convert';

import 'package:admin_panel/auth&database/storage_methods.dart';
import 'package:admin_panel/models/category_model.dart' as cate;
import 'package:admin_panel/models/order_model.dart' as od;
import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/models/seller_model.dart' as model;
import 'package:admin_panel/provider/seller_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../models/seller_model.dart';

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
        uid: credential.user!.uid,
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
        isPromoted: false,
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
      //***********************************************************************   Storage Pic Deletion..

      final CollectionReference productCollection =
          FirebaseFirestore.instance.collection("products");
      QuerySnapshot snap =
          await productCollection.where('id', isEqualTo: id).get();
      var myData = snap.docs.map((e) => e.data()).toList();
      var data = myData[0] as Map;
      String picUrl = data['photoUrl'];

      final httpsReference = FirebaseStorage.instance.refFromURL(picUrl);
      await httpsReference.delete();

      //***********************************************************************

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

  // retrieving seller
  Stream<List<Seller>> get seller {
    return firestore.collection('sellers').snapshots().map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map(
                (DocumentSnapshot documentSnapshot) => Seller(
                  uid:
                      (documentSnapshot.data()! as Map<String, dynamic>)['uid'],
                  name: (documentSnapshot.data()!
                      as Map<String, dynamic>)['name'],
                  phoneNum: (documentSnapshot.data()!
                      as Map<String, dynamic>)['phoneNum'],
                  address: (documentSnapshot.data()!
                      as Map<String, dynamic>)['address'],
                  email: (documentSnapshot.data()!
                      as Map<String, dynamic>)['email'],
                ),
              )
              .toList(),
        );
  }

  // alternative retrieving list of cattegories for dropdown
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

  // retrieving list of cattegories for dropdown
  Stream<List<cate.Category>> get category {
    return firestore.collection('category').snapshots().map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map(
                (DocumentSnapshot documentSnapshot) => cate.Category(
                  catUid: (documentSnapshot.data()!
                      as Map<String, dynamic>)['catUid'],
                  thumbnailPicUrl: (documentSnapshot.data()!
                      as Map<String, dynamic>)['thumbnailPicUrl'],
                  name: (documentSnapshot.data()!
                      as Map<String, dynamic>)['name'],
                  userName: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userName'],
                  userUid: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userUid'],
                ),
              )
              .toList(),
        );
  }

  // retrieving list of orders
  Stream<List<od.Order>> get orders {
    return firestore
        .collection('allorders')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => od.Order(
                  userId: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userId'],
                  orderId: (documentSnapshot.data()!
                      as Map<String, dynamic>)['orderId'],
                  name: (documentSnapshot.data()!
                      as Map<String, dynamic>)['name'],
                  price: (documentSnapshot.data()!
                      as Map<String, dynamic>)['price'],
                  userName: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userName'],
                  userAddress: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userAddress'],
                  userPhone: (documentSnapshot.data()!
                      as Map<String, dynamic>)['userPhone'],
                  orderDate: (documentSnapshot.data()!
                      as Map<String, dynamic>)['orderDate'],
                  status: (documentSnapshot.data()!
                      as Map<String, dynamic>)['status'],
                  quantity: (documentSnapshot.data()!
                      as Map<String, dynamic>)['quantity'],
                  category:
                      (documentSnapshot.data()! as Map<String, dynamic>)['category'],
                  desc: (documentSnapshot.data()! as Map<String, dynamic>)['desc'],
                  photoUrl: (documentSnapshot.data()! as Map<String, dynamic>)['photoUrl'],
                  payMode: (documentSnapshot.data()! as Map<String, dynamic>)['payMode']),
            )
            .toList());
  }

  // delete category
  Future<String> delCat(cate.Category category, BuildContext context) async {
    if (auth.currentUser!.uid != 'ELO4z0WvXLgHgHSlVuagYBrunXK2') {
      return 'Only "@MyBhrmar" has option to delete this.';
    }
    String res = "Some error Occurred";
    try {
      //***************************************************************

      // delete from firebase storage..........
      final httpsReference =
          FirebaseStorage.instance.refFromURL(category.thumbnailPicUrl);
      await httpsReference.delete();

      //**************************************************************

      await firestore.collection('category').doc(category.catUid).delete();

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
  Future<String> addCat(
      BuildContext context, Uint8List image, String name) async {
    String res = "Some error Occurred";
    try {
      List<String> cats = Provider.of<List<String>>(context, listen: false);
      if (cats.contains(name)) {
        return 'Category "$name" is already present in the list.';
      }
      cats.add(name);
      await firestore
          .collection('cattegories')
          .doc('AQrjPBBZ6hbdodDId8wN')
          .set({
        'listCat': cats,
      });
      String uid = const Uuid().v1();
      Seller seller =
          // ignore: use_build_context_synchronously
          Provider.of<SellerProvider>(context, listen: false).getSeller;
      String thumbnailPicUrl = await StorageMethods().uploadImagetoStorage(
        'categorythumbnail',
        image,
        uid,
      );

      cate.Category category = cate.Category(
        catUid: uid,
        thumbnailPicUrl: thumbnailPicUrl,
        name: name,
        userName: seller.name,
        userUid: seller.uid,
      );
      await firestore.collection('category').doc(uid).set(
            category.toMap(),
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

  // delete order from allorders
  Future<String> deleteOrder(String id, String buyerId) async {
    // print(id);
    if (auth.currentUser!.uid != 'ELO4z0WvXLgHgHSlVuagYBrunXK2') {
      return 'Only "MyBhrmar" has option to decide this.';
    }
    String res = "Some error Occurred";
    try {
      await firestore.collection('allorders').doc(id).update({
        'status': 'delivered',
      });
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('UserTokens');
      DocumentSnapshot snapshot = await collectionReference.doc(buyerId).get();
      sendPushMessage(
        (snapshot.data() as Map<String,dynamic>)['token'],
        "Your Order is Delivered",
        "Order Delivered",
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

  void sendPushMessage(
    String token,
    String body,
    String title,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAEJpdyQU:APA91bEm3DSJuAjMvxQOXw9ITXx2C6CORljTw6AwYXtk7R3ON43qNRKt_7V_ScYZM10uObH1zvJwjxo1jT1KjIiTWOc6jLxNf2gz8zRgBr8UMgl_Uz2ckVkHikiSPlgjW8Q-eLUWfYsR',
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "dbfood"
          },
          "to": token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
        // Shared().snackbar(
        //   message: "Could not send notification. Please try later.",
        //   context: context,
        // );
      }
    }
  }

  // promote a product
  Future<String> promoteProduct(String productUid) async {
    String res = 'Some error Occurred.';
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productUid)
          .update({
        'isPromoted': true,
      });
      res = 'Success';
      return res;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      return "Could not process";
    } catch (e) {
      return res;
    }
  }

  // demote a product
  Future<String> demoteProduct(String productUid) async {
    String res = 'Some error Occurred.';
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productUid)
          .update({
        'isPromoted': false,
      });
      res = 'Success';
      return res;
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      return "Could not process";
    } catch (e) {
      return res;
    }
  }
}
