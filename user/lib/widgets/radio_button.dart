import 'package:flutter/material.dart';

Widget selectbutton() {
  return Container(
    height: 20,
    width: 20,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 1.4, color: Colors.teal),
    ),
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal,
      ),
    ),
  );
}

Widget notselectbutton() {
  return Container(
    height: 20,
    width: 20,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 1.4, color: Colors.teal),
    ),
  );
}
