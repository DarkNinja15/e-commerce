// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../screens/see_all_promotion_page.dart';

Widget Roww() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1.h),
    width: double.infinity,
    height: 8.h,
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
    height: 3.h,
    margin: EdgeInsets.symmetric(horizontal: 4.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Featured Product',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.teal, fontSize: 9.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                ctx,
                MaterialPageRoute(
                    builder: (context) => const SeeAllPromotionPage()));
          },
          child: Text(
            'See All',
            style: TextStyle(color: const Color.fromRGBO(255, 176, 57, 1), fontSize: 9.sp),
          ),
        ),
      ],
    ),
  );
}
