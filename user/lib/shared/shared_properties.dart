import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Shared {

  snackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // imagepicker(ImageSource source) async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? file = await imagePicker.pickImage(
  //     source: source,
  //   );
  //   if (file != null) {
  //     return await file.readAsBytes();
  //   }
  //   // print('No Image Selected');
  // }

}
