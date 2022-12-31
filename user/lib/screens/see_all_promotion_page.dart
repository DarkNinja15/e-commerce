import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../widgets/My_Widgets.dart';
import '../widgets/product_tile.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Featured Product',
          style: TextStyle(letterSpacing: 1.4, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Roww(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: const Text(
                    'Featured Product',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.teal,
                        fontSize: 17),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 10,
                  itemCount: promotedProds.length,
                  itemBuilder: (context, i) {
                    return productTile(
                        promotedProds[i].photoUrl,
                        promotedProds[i].name,
                        promotedProds[i].desc,
                        promotedProds[i].price,
                        promotedProds[i].discount);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
