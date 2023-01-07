// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/services/Database_Service.dart';
import 'package:user/shared/shared_properties.dart';
import '../../models/product_model.dart';
import 'Cart_Page.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required this.prod}) : super(key: key);

  final Product prod;

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    bool isWishListed = user.wishlist.contains(widget.prod.id);
    bool isInCart = user.cart.contains(widget.prod.id);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        foregroundColor: Colors.blueGrey,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyCart()));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  ))
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(widget.prod.photoUrl),
                      fit: BoxFit.contain)),
            ),
            Container(
              height: 35,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15, bottom: 5),
                      child: GestureDetector(
                          onTap: () async {
                            final res = await DatabaseService()
                                .addProdToWishList(widget.prod.id, context);
                            setState(() {});
                            if (res == 'added') {
                              Shared().snackbar2(
                                'Product added to wishlist.',
                                context,
                                Colors.green,
                              );
                            } else if (res == 'removed') {
                              Shared().snackbar2(
                                'Product removed from wishlist.',
                                context,
                                Colors.redAccent,
                              );
                            } else {
                              Shared().snackbar(
                                res,
                                context,
                              );
                            }
                          },
                          child: isWishListed
                              ? const Icon(Icons.favorite,
                                  color: Colors.redAccent, size: 35)
                              : const Icon(Icons.favorite_outline_outlined,
                                  color: Colors.blueGrey, size: 35))),
                ],
              ),
            ),
            const Divider(thickness: 1.5),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                widget.prod.name,
                style: const TextStyle(fontSize: 30, color: Colors.teal, fontStyle: FontStyle.italic, letterSpacing: 2.5),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: Text(
                widget.prod.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.grey, fontStyle: FontStyle.italic, letterSpacing: 2, fontWeight: FontWeight.w300),
              ),
            ),
            const Divider(),
            widget.prod.discount > 0
                ? Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      'NOTE : There is a discount of ${widget.prod.discount.round()}%  on this product if your order quantity on this product is more than ${widget.prod.discountProductLimit} .',
                      style: const TextStyle(
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.05),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.075,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5, color: const Color.fromRGBO(255, 176, 57, 1)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: GestureDetector(
                  onTap: () async {
                    final res = await DatabaseService()
                        .addProdToCart(widget.prod.id, context);
                    setState(() {});
                    if (res == 'added') {
                      Shared().snackbar(
                        'Product added to cart.',
                        context,
                      );
                    } else if (res == 'removed') {
                      Shared().snackbar(
                        'Product removed from cart.',
                        context,
                      );
                    } else {
                      Shared().snackbar(
                        res,
                        context,
                      );
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Center(
                        child: isInCart
                            ? const Text(
                                'Added to cart',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 176, 57, 1),
                                    fontSize: 17),
                              )
                            : const Text(
                                'Add to Cart',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 176, 57, 1),
                                    fontSize: 17),
                              )),
                  ),
                ),
              ),
            ),
            const VerticalDivider(),
            GestureDetector(
              onTap: () async {
                final res = await DatabaseService()
                    .addProdToCart(widget.prod.id, context);
                if (res == 'added') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCart(),
                    ),
                  );
                } else if (res == 'removed') {
                  final res = await DatabaseService()
                      .addProdToCart(widget.prod.id, context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCart(),
                    ),
                  );
                } else {
                  Shared().snackbar(
                    res,
                    context,
                  );
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(255, 176, 57, 1),
                  ),
                  child: const Center(
                      child: Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
