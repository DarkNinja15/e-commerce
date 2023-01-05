// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: non_constant_identifier_names
Widget productTile(String url, String Name, String Description, double price,
    double discount, BuildContext ctx) {
  return UnconstrainedBox(
    child: Container(
      height: 25.h,
      width: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        // border: Border.all(width: 1),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      child: Column(
        children: [
          Container(
            height: 14.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp),
              ),
              color: Colors.blueGrey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp),
              ),
              child: SizedBox.expand(
                  child: Image.network(url, fit: BoxFit.fitWidth)),
            ),
          ),
          Container(
            height: 10.h,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.sp),
                bottomRight: Radius.circular(12.sp),
              ),
            ),
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.6.h),
                  Text(
                    Name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 9.sp),
                  ),
                  SizedBox(height: 0.6.h),
                  Text(
                    Description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 7.sp),
                  ),
                  SizedBox(height: 0.6.h),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '₹${price.round()}',
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      // const SizedBox(width: 10),
                      // FittedBox(
                      //     fit: BoxFit.contain,
                      //     child: Text(
                      //       '₹$price',
                      //       style: const TextStyle(
                      //         color: Colors.redAccent,
                      //         fontWeight: FontWeight.bold,
                      //         decoration: TextDecoration.lineThrough,
                      //       ),
                      //       overflow: TextOverflow.ellipsis,
                      //     ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
