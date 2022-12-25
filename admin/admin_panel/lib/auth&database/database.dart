import 'package:admin_panel/auth&database/storage_methods.dart';
import 'package:admin_panel/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Database {
  final firestore = FirebaseFirestore.instance;

  Future<String> addProduct(
    String name,
    String desc,
    String price,
    Uint8List? image,
    int quantity,
    double discount,
    int discountProductLimit,
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
}
