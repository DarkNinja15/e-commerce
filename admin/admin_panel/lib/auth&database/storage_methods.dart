import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageMethods {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // add image to firebase storage
  Future<String> uploadImagetoStorage(
      String childname, Uint8List file, String prodId) async {
    // create folder name childname and inside that create a folder of userid in which file is stored
    Reference ref = firebaseStorage.ref().child(childname).child(prodId);

    // putting file in uid folder.
    UploadTask uploadTask = ref.putData(file);
    // await the uploadtask
    TaskSnapshot snap = await uploadTask;
    // getting downloadUrl
    String downloadUrl = (await snap.ref.getDownloadURL()).toString();
    return downloadUrl;
  }
}
