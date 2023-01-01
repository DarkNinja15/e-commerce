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

    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories', style: TextStyle(fontWeight: FontWeight.w400,
          letterSpacing: 0.8,),),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cats.length,
          itemBuilder: (context, i) {
            return Container(
              height: 145,
              width: 335,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.yellow),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                child: Image.network(cats[i].thumbnailPicUrl, fit: BoxFit.fill,),
                borderRadius: BorderRadius.circular(30),
              ),
            );
          }
      )
    );
  }
}
