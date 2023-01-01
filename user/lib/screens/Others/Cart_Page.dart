// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/widgets/cart_tile.dart';
import 'package:user/models/category_model.dart' as cate;

import '../../models/product_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  List<Product> carts = [];
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    carts = Provider.of<List<Product>>(context) ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            letterSpacing: 0.65,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
        ),
                const Text('Select All Item', style: TextStyle(fontSize: 17, color: Colors.teal, letterSpacing: 1),)
              ],
            ),
          ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: carts.length,
                  itemBuilder: (context, i){
                  return Cart_tile(carts[i].photoUrl, carts[i].name, carts[i].price);
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.11,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: const Center(
                child: Text('₹', style: TextStyle(fontSize: 30, color: Colors.teal),),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(255, 176, 57, 1),
                ),
                child: const Center(child: Text('Buy Now', style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
