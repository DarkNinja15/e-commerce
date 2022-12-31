// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/category_model.dart' as cate;

class All_Categories extends StatefulWidget {
  const All_Categories({Key? key}) : super(key: key);

  @override
  State<All_Categories> createState() => _All_CategoriesState();
}

class _All_CategoriesState extends State<All_Categories> {
  List<cate.Category> cats = [];
  @override
  Widget build(BuildContext context) {
    cats = Provider.of<List<cate.Category>>(context);
    // print(cats);

    // cats array contains all the categories, to access name => cats[index].name etc....

    return const Scaffold(
      body: Center(
        child: Text('All_Categories_Page'),
      ),
    );
  }
}
