import 'package:flutter/material.dart';

class DropDownItemGenerator extends StatelessWidget {
  final String value;

  const DropDownItemGenerator({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      value: value,
      child: Text(value),
    );
  }
}
