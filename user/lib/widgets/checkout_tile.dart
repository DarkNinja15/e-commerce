// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget tile(
    var width, String url, String name, String total_price, String quality) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.white),
    margin: EdgeInsets.all(width * 0.025),
    padding: EdgeInsets.all(width * 0.025),
    width: width,
    height: 15.h,
    child: Row(
      children: [
        Container(
          height: width * 0.24,
          width: width * 0.24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey.shade200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: width * 0.4,
          margin: const EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 9.sp,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.teal),
              ),
              Text(
                'Total Price : ₹$total_price',
                style: TextStyle(
                    fontSize: 7.5.sp,
                    color: Colors.deepPurple,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                'Quantity : $quality',
                style: TextStyle(fontSize: 7.5.sp, color: Colors.deepPurple),
              )
            ],
          ),
        )
      ],
    ),
  );
}
