// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class All_Categories extends StatefulWidget {
  const All_Categories({Key? key}) : super(key: key);

  @override
  State<All_Categories> createState() => _All_CategoriesState();
}

class _All_CategoriesState extends State<All_Categories> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('All_Categories_Page'),
      ),
    );
  }
}
