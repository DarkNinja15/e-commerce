// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/category_model.dart' as cate;
import 'package:user/screens/Others/category_detail.dart';
import 'package:user/widgets/loading.dart';

class All_Categories extends StatefulWidget {
  const All_Categories({Key? key}) : super(key: key);

  @override
  State<All_Categories> createState() => _All_CategoriesState();
}

class _All_CategoriesState extends State<All_Categories> {
  List<cate.Category> cats = [];
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cats = Provider.of<List<cate.Category>>(context);
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(cats.length);

    // cats array contains all the categories, to access name => cats[index].name etc....

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Categories',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: isLoading
            ? const Loading()
            : ListView.builder(
                itemCount: cats.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 145,
                    width: 335,
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.yellow),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryDetail(
                              name: cats[i].name,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          cats[i].thumbnailPicUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                }));
  }
}
