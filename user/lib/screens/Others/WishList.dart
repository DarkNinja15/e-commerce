// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/widgets/loading.dart';

import '../../widgets/product_tile.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Product> wishListedProducts = [];
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    List wishListProdIds =
        (Provider.of<UserProvider>(context, listen: false).getUser.wishlist);
    List<Product> allprods = Provider.of<List<Product>>(context, listen: false);
    for (var i = 0; i < wishListProdIds.length; i++) {
      for (var j = 0; j < allprods.length; j++) {
        if (allprods[j].id == wishListProdIds[i]) {
          wishListedProducts.add(allprods[j]);
        }
      }
    }
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
    // ************************************************
    // print(wishListProdIds);
    // print(allprods.length);
    // print(wishListedProducts.length);
    // **the array wishlistedProducts contains all the wishlistedProducts, to access wishlistedProducts[index].name etc...**
    // *********************************************************************
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Wishlist',
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
          : wishListedProducts.isEmpty
              ? Column(
                  children: const [
                    Image(image: AssetImage('assets/void.png')),
                    Text(
                      'Nothing to show\n\nAdd items you like',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 33),
                    )
                  ],
                )
              : MasonryGridView.count(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 10,
                  itemCount: wishListedProducts.length,
                  itemBuilder: (context, i) {
                    return productTile(
                        wishListedProducts[i].photoUrl,
                        wishListedProducts[i].name,
                        wishListedProducts[i].desc,
                        wishListedProducts[i].price,
                        wishListedProducts[i].discount);
                  }),
    );
  }
}
