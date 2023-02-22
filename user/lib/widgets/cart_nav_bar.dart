// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:user/screens/checkout_page.dart';
import '../shared/shared_properties.dart';
import '../models/product_model.dart';

Widget Nav(BuildContext ctx, int amount, List<Product> prod,
    List<int> isSelected, List<int> count) {
  return Container(
    height: MediaQuery.of(ctx).size.height * 0.09,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.5,
          child: Center(
            child: Text(
              '₹ ${amount.toString()}',
              style: const TextStyle(fontSize: 30, color: Colors.teal),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(isSelected.contains(1)==false){
              Shared().snackbar2('Please Select at least One Product', ctx, Colors.redAccent);
              return;
            }
            Navigator.pushReplacement(
                ctx,
                MaterialPageRoute(
                    builder: (context) => Checkout(
                          prod: prod,
                          isSelected: isSelected,
                          count: count,
                        )));
          },
          child: SizedBox(
            width: MediaQuery.of(ctx).size.width * 0.5,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
  );
}
