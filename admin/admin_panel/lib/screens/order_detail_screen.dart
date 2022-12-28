import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/shared/shared_properties.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final dynamic snap;
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
    final size = MediaQuery.of(context).size.width;
    print(size);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'OrderId: ${widget.snap['orderId']}',
          overflow: TextOverflow.clip,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                  widget.snap['photoUrl'],
                ),
              ),
            ),
            const Divider(thickness: 3),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children : [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Name :     ', style: TextStyle(fontWeight: FontWeight.w500),)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['name']))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Quantity Ordered :    ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['quantity'])),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Price/item :    ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text('${double.parse(widget.snap['price']) / double.parse(widget.snap['quantity'])}')),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Total Price :    ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['price']))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Description :    ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['desc'])
                      )
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Order Status :   ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['status'])),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Order Date  :   ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['orderDate'])),
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Ordered By :   ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['userName']))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Contact No.  :   ', style: TextStyle(fontWeight: FontWeight.w500))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['userPhone']))
                    ],
                  ),
                  const Divider(height: 35),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.25,
                          child: const Text('Address  :   ', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                          child: Text(widget.snap['userAddress']),
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
            InkWell(
              onTap: _orderDelviered,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 176, 57, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.width * 0.05),
                child: const Center(
                  child: Text(
                    'Order Delivered',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _orderDelviered() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure that the order is delivered?",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "You will not be able to undo this change...",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: const TextStyle(),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                // filled: true,
                hintText: "It is case sensitive.",
                labelText: 'Enter product name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Color.fromRGBO(255, 176, 57, 1),),
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Color.fromRGBO(255, 176, 57, 1),),
                    borderRadius: BorderRadius.circular(35)
                  ),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.delivery_dining,
                      color: Color.fromRGBO(255, 176, 57, 1),
                    ),
                    onPressed: () async {
                      if (controller.text.isEmpty) {
                        Shared().snackbar(
                          message: 'Please enter product name',
                          context: context,
                        );
                        return;
                      }
                      if (controller.text == widget.snap['name']) {
                        // print(widget.snap['orderId']);
                        String s = widget.snap['orderId'];
                        final res = await Database().deleteOrder(s);
                        if (res != 'Success') {
                          Shared().snackbar(
                            message: res,
                            context: context,
                          );
                          return;
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          Shared().snackbar(
                            message: 'Successfully Delivered',
                            context: context,
                          );
                          return;
                        }
                      } else {
                        Shared().snackbar(
                          message:
                              'Please enter the name of the product correctly. It is case sensitive.',
                          context: context,
                        );
                        return;
                      }
                    },
                    label: const Text(
                      "Delivered",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 176, 57, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
