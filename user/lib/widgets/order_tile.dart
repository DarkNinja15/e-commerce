// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget Order_tile(var width, String url, String name, String total_price,
    String quality, String Status) {
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
        SizedBox(width: width*0.01),
        Container(
          // decoration: BoxDecoration(border: Border.all(width: 1)),
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
                    color: Colors.deepPurple, overflow: TextOverflow.ellipsis, fontSize: 6.5.sp),
              ),
              Text(
                'Quantity : $quality',
                style: TextStyle(color: Colors.deepPurple, fontSize: 6.5.sp),
              ),
              Text(
                'Status : $Status',
                style: TextStyle(color: Colors.deepPurple, fontSize: 6.5.sp),
              ),
              // Text('Status : $quality', style: TextStyle(color: Colors.deepPurple),)
            ],
          ),
        )
      ],
    ),
  );
}
