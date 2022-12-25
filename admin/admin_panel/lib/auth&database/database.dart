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
  ) async {
    String res = "Some error Occured";
    if (name.isEmpty || desc.isEmpty || price.isEmpty || image == null) {
      return "Please enter all details.";
    }
    try {
      final photoUrl =
          await StorageMethods().uploadImagetoStorage('products', image);
      String prodId = const Uuid().v1();
      Product product = Product(
        id: prodId,
        photoUrl: photoUrl,
        name: name,
        desc: desc,
        price: double.parse(price),
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
