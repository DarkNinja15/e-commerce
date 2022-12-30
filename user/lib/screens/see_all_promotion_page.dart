import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class SeeAllPromotionPage extends StatefulWidget {
  const SeeAllPromotionPage({super.key});

  @override
  State<SeeAllPromotionPage> createState() => _SeeAllPromotionPageState();
}

class _SeeAllPromotionPageState extends State<SeeAllPromotionPage> {
  // bool isLoading = false;
  List<Product> promotedProds = [];

  // promotedProds contains all the promoted products.

  @override
  void initState() {
    // isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    promotedProds = Provider.of<List<Product>>(context)
        .where((element) => element.isPromoted)
        .toList();
    // print('..');
    // print(promotedProds.length);
    // Future.delayed(
    //     const Duration(
    //       seconds: 2,
    //     ), () {
    //   isLoading = false;
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Promotion_Page'),
      ),
    );
  }
}
