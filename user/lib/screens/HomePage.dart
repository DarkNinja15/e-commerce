// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Product> allProds = [];
  List<Product> promotedProds = [];

  // allProds contains all the products.
  // promotedProds contains all the promoted products.

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allProds = Provider.of<List<Product>>(context);
    promotedProds = allProds.where((element) => element.isPromoted).toList();
    // print(allProds.length);
    // print('..');
    // print(promotedProds.length);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home_Page'),
      ),
    );
  }
}
