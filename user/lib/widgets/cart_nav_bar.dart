import 'package:flutter/material.dart';

Widget Nav(BuildContext ctx, int amount){
  return Container(
    height: MediaQuery.of(ctx).size.height * 0.09,
    width: double.infinity,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.5,
          child: Center(
            child: Text(
              '₹ ${amount.toString()}',
              style: TextStyle(fontSize: 30, color: Colors.teal),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.4,
          child: Container(
            margin:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
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
  );
}