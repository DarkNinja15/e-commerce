import 'package:flutter/material.dart';

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

  snackbar2(String message, BuildContext context, Color clr) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: clr,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
}
