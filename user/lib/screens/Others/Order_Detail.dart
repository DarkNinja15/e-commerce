// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/order_model.dart';

class OrderDetail extends StatefulWidget {
  final Order snap;
  const OrderDetail({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    // print(size);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        title: Text(
          'OrderId: ${widget.snap.orderId}',
          overflow: TextOverflow.clip,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: const Color.fromRGBO(255, 176, 57, 1),
                ),
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.width * 0.05),
              child: Image(
                image: NetworkImage(
                  widget.snap.photoUrl,
                ),
              ),
            ),
            const Divider(thickness: 3),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text(
                            'Name :     ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.name))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Quantity Ordered :    ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text((widget.snap.quantity).toString())),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Price/item :    ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                              '${double.parse(widget.snap.price) / (widget.snap.quantity)}')),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Total Price :    ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.price))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Description :    ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.desc))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Order Status :   ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.status)),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Order Date  :   ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.orderDate)),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Ordered By :   ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.userName))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: const Text('Contact No.  :   ',
                              style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(widget.snap.userPhone))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text('Address  :   ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(widget.snap.userAddress),
                      )
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text('Paymode  :   ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(widget.snap.payMode),
                      )
                    ],
                  ),
                  const Divider(height: 35),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
