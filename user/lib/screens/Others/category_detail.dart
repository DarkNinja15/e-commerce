import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/widgets/loading.dart';

class CategoryDetail extends StatefulWidget {
  final String name;
  const CategoryDetail({super.key, required this.name});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  bool isLoading = false;
  List<Product> catProds = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    catProds = Provider.of<List<Product>>(context)
        .where((element) => element.category == widget.name)
        .toList();
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
    // catProds contains all the products related to that category.
    // print(catProds);

    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
              centerTitle: true,
            ),
            body: Container(),
          );
  }
}
