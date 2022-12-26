import 'package:admin_panel/auth&database/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Shared {
  snackbar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textAlign: TextAlign.center,
    )));
  }

  imagepicker(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: source,
    );
    if (file != null) {
      return await file.readAsBytes();
    }
    // print('No Image Selected');
  }

  bool deleteProduct(BuildContext context, String id, String sellerUid) {
    bool f = false;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to delete this Product?",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "You will not be able to undo this change...",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.delete,
              color: Color.fromRGBO(204, 82, 88, 1),
            ),
            onPressed: () async {
              final res = await Database().deleteProduct(
                id,
                sellerUid,
              );
              if (res != 'Success') {
                snackbar(
                  message: res,
                  context: context,
                );
              } else {
                snackbar(
                  message: 'Product Deleted Successfully',
                  context: context,
                );
                f = true;
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            label: const Text(
              "Delete",
              style: TextStyle(
                color: Color.fromRGBO(204, 82, 88, 1),
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
    return f;
  }
}
