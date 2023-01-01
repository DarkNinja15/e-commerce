// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required this.prod}) : super(key: key);

  final Product prod;

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                  ))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 20,
              color: Colors.white,
            ),
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
              height: 20,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    widget.prod.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.red,
                    )),
              ],
            ),
            const Divider(),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: Text(
                widget.prod.desc,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                'NOTE : There is a discount of ${widget.prod.discount.round()}%  on this product if your order quantity on this product is more than ${widget.prod.discountProductLimit} .',
                style: const TextStyle(
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.075,
        color: Colors.white,
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
                child: const Center(
                    child: Text(
                  'Add to Cart',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 176, 57, 1), fontSize: 20),
                )),
              ),
            ),
            const VerticalDivider(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(255, 176, 57, 1),
                ),
                child: const Center(
                    child: Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}