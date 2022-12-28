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
    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OrderId: ${widget.snap['orderId']}',
          overflow: TextOverflow.clip,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: const Color.fromRGBO(255, 176, 57, 1),
                ),
              ),
              height: size * 0.35,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.width * 0.05),
              child: Image(
                image: NetworkImage(
                  widget.snap['photoUrl'],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Name : ${widget.snap['name']}',
                ),
                Text('Quantity Ordered: ${widget.snap['quantity']}')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Price/item : ${double.parse(widget.snap['price']) / double.parse(widget.snap['quantity'])}',
                ),
                Text('Total Price: ${widget.snap['price']}')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Container(
                color: Colors.transparent,
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Description:\n ${widget.snap['desc']}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Order Status : ${widget.snap['status']}',
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Order Date: ${widget.snap['orderDate']}'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Ordered By : ${widget.snap['userName']}',
                ),
                Text('Phone: ${widget.snap['userPhone']}')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Container(
                color: Colors.transparent,
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Address:  ${widget.snap['userAddress']}',
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _orderDelviered,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal,
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
                      fontWeight: FontWeight.bold,
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
          TextField(
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
          TextButton.icon(
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
          TextButton.icon(
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
        ],
      ),
    );
  }
}
