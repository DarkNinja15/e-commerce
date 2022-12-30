import 'package:flutter/material.dart';

Widget productTile(String url, String Name, String Description, double price, double discount){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      // border: Border.all(width: 1),
    ),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    child: SizedBox(
      // height: 206,
      // width: 50,
      child: Column(
        children: [
          Container(
            height: 110,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),),
              child: SizedBox.expand(child: Image.network(url, fit: BoxFit.fill)),
            ),
          ),
          Container(
            height: 94,
            padding: EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30),),
            ),
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(Name, textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),),
                  SizedBox(height: 5),
                  Text(Description, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text('₹$price', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 17, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(width: 10),
                      FittedBox(
                              fit: BoxFit.contain,
                              child: Text('₹$price', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, decoration: TextDecoration. lineThrough,), overflow: TextOverflow.ellipsis,))
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