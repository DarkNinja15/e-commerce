import 'package:flutter/material.dart';

class Shared {
  snackbar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textAlign: TextAlign.center,
    )));
  }
}
