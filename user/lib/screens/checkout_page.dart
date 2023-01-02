import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/screens/Others/Cart_Page.dart';

import '../models/product_model.dart';
import '../provider/user_provider.dart';
import '../widgets/checkout_tile.dart';

class Checkout extends StatefulWidget {
  const Checkout(
      {Key? key,
      required this.prod,
      required this.isSelected,
      required this.count})
      : super(key: key);

  final List<Product> prod;
  final List<int> isSelected;
  final List<int> count;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  List<Product> prod = [];
  List<int> count = [];
  int totalcost = 0;
  bool cashondelivery = false;

  void fun() {
    for (int i = 0; i < widget.prod.length; i++) {
      if (widget.isSelected[i] == 1) {
        prod.add(widget.prod[i]);
        count.add(widget.count[i]);
        totalcost += widget.prod[i].price.toInt() * widget.count[i];
      }
    }
  }

  @override
  void initState() {
    fun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(count);
    var width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).getUser;
    namecontroller.text = user.userName;
    phonecontroller.text = user.phoneNo;
    addresscontroller.text = user.address;
    emailcontroller.text = user.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyCart()));
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.25,
                        child: const Text(
                          'Name : ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.60,
                        child: TextField(
                          controller: namecontroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.25,
                        child: const Text(
                          'Contact No : ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.60,
                        child: TextField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.25,
                        child: const Text(
                          'Email \nAddress : ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.60,
                        child: TextField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.25,
                        child: const Text(
                          'Shipping \nAddress : ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.60,
                        child: TextField(
                          controller: addresscontroller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: prod.length,
                  itemBuilder: (context, i) {
                    return tile(
                        width,
                        prod[i].photoUrl,
                        prod[i].name,
                        (prod[i].price * count[i]).toString(),
                        prod[i].quantity.toString());
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Payment : ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.teal),
                  ),
                  Text(
                    totalcost.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.blueGrey),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              // height: 105,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select a Payment Method',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: cashondelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            cashondelivery = value!;
                          });
                        },
                      ),
                      const Text('Cash On Delivery')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: !cashondelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            cashondelivery = !value!;
                          });
                        },
                      ),
                      const Text('Pay Online')
                    ],
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 176, 57, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    child: const Center(
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
