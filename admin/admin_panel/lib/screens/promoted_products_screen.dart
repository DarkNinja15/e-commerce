import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:admin_panel/widgets/loading.dart';
import 'package:admin_panel/widgets/promoted_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/seller_model.dart';

class PromotedProducts extends StatefulWidget {
  const PromotedProducts({super.key});

  @override
  State<PromotedProducts> createState() => _PromotedProductsState();
}

class _PromotedProductsState extends State<PromotedProducts> {
  TextEditingController controller = TextEditingController();
  List<Product> prods = [];
  List<Product> searchResult = [];
  bool isLoading = false;
  List<Seller> seller = [];

  void searchquery(String query) {
    setState(() {
      searchResult = (prods.where(
          (element) => element.name.toLowerCase().startsWith(query))).toList();
    });
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didChangeDependencies() {
    prods = Provider.of<List<Product>>(context)
        .where((element) => (element.isPromoted))
        .toList();
    seller = Provider.of<List<Seller>>(context);
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
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            drawer: const Drawerc(),
            appBar: AppBar(
              elevation: 0,
              title: const Text('Promoted Products'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: TextField(
                    controller: controller,
                    onChanged: (query) {
                      searchquery(query.toLowerCase());
                    },
                    style: const TextStyle(),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search for a Product",
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                prods.isEmpty
                    ? Column(
                        children: const [
                          Image(
                            image: AssetImage(
                              'assets/void.png',
                            ),
                          ),
                          Text(
                            'Nothing to Show',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 33,
                            ),
                          ),
                        ],
                      )
                    : controller.text == ''
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: prods.length,
                              itemBuilder: (context, index) {
                                Seller sel = seller.firstWhere((element) =>
                                    element.uid == prods[index].sellerUid);
                                return PromotedProductTile(
                                  snap: prods[index],
                                  sellerName: sel.name,
                                  sellerPhone: sel.phoneNum,
                                );
                              },
                            ),
                          )
                        : searchResult.isEmpty
                            ? Expanded(
                                child: ListView(
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                        'assets/void.png',
                                      ),
                                    ),
                                    Text(
                                      'Nothing to Show',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 33,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchResult.length,
                                    itemBuilder: (context, index) {
                                      // print(searchResult[index]['name']);
                                      Seller sel = seller.firstWhere(
                                          (element) =>
                                              element.uid ==
                                              prods[index].sellerUid);
                                      return PromotedProductTile(
                                        snap: searchResult[index],
                                        sellerName: sel.name,
                                        sellerPhone: sel.phoneNum,
                                      );
                                    }),
                              )
              ],
            ),
          );
  }
}
