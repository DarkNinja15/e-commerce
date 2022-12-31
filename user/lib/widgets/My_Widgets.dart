// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../screens/see_all_promotion_page.dart';

Widget Roww() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: 65,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/home/1.png'),
        Image.asset('assets/home/2.png'),
        Image.asset('assets/home/3.png'),
        Image.asset('assets/home/4.png'),
        Image.asset('assets/home/5.png'),
      ],
    ),
  );
}

Widget Roww2(BuildContext ctx) {
  return Container(
    height: 25,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Featured Product',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.teal, fontSize: 17),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (context) => const SeeAllPromotionPage()));
          },
          child: const Text(
            'See All',
            style: TextStyle(color: Color.fromRGBO(255, 176, 57, 1)),
          ),
        ),
      ],
    ),
  );
}
