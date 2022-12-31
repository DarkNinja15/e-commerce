// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/provider/user_provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    // ************************************************
    List wishListProdIds =
        (Provider.of<UserProvider>(context).getUser.wishlist);
    // print(wishListProdIds);
    List<Product> allprods = Provider.of<List<Product>>(context);
    // print(allprods.length);
    List<Product> wishListedProducts = [];
    for (var whislistedProdId in wishListProdIds) {
      Product product = allprods
          .firstWhere((element) => element.id == whislistedProdId.toString());
      wishListedProducts.add(product);
    }
    // print(wishListedProducts.length);
    // **the array wishlistedProducts contains all the wishlistedProducts, to access wishlistedProducts[index].name etc...**
    // *********************************************************************
    return const Scaffold(
      body: Center(
        child: Text('WishList_Page'),
      ),
    );
  }
}
