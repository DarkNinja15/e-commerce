import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user/models/order_model.dart' as ord;
import 'package:user/screens/Others/Cart_Page.dart';
import 'package:user/shared/shared_properties.dart';
import 'package:user/widgets/Order_notice.dart';
import 'package:uuid/uuid.dart';

import '../models/product_model.dart';
import '../provider/user_provider.dart';
import '../widgets/checkout_tile.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController controller = TextEditingController();

  List<Product> prod = [];
  List<int> count = [];
  int totalcost = 0;
  bool f = true;
  // bool cashondelivery = false;

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
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    emailcontroller.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(count);
    var width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).getUser;
    if (f) {
      namecontroller.text = user.userName;
      phonecontroller.text = user.phoneNo;
      addresscontroller.text = user.address;
      emailcontroller.text = user.email;
      f = false;
    }
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
                        (prod[i].price * count[i]).round().toString(),
                        count[i].toString());
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
                        value: true,
                        onChanged: (_) {},
                      ),
                      const Text('Cash On Delivery')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      const Text(
                        'Pay Online',
                        style: TextStyle(color: Colors.blueGrey),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: _checkout,
                    child: Container(
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

  void _checkout() {
    int randomNum = Random().nextInt(900) + 100;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "$randomNum",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "Enter the above number to proceed",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: const TextStyle(),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                // filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromRGBO(255, 176, 57, 1),
                      ),
                      borderRadius: BorderRadius.circular(35)),
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
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromRGBO(255, 176, 57, 1),
                      ),
                      borderRadius: BorderRadius.circular(35)),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.confirmation_num,
                      color: Color.fromRGBO(255, 176, 57, 1),
                    ),
                    onPressed: () async {
                      if (controller.text != randomNum.toString()) {
                        Navigator.of(context).pop();
                        Shared().snackbar(
                          "Please Enter the number correctly.",
                          context,
                        );
                        return;
                      } else {
                        doAll().then((value) {
                          if (value == true) {
                            Navigator.of(context).pop();
                            Order_Succes(context);
                          } else if (value == false) {
                            Shared().snackbar2('Server Error. Try Again',
                                context, Colors.redAccent);
                          }
                        });

                        // the above function will do all the task after checkout.
                      }
                    },
                    label: const Text(
                      "Proceed",
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

  Future<bool> doAll() async {
    // ! make cart empty
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    List cartProds = user.cart;
    // print(cartProds);
    for (var i in prod) {
      cartProds.remove(i.id);
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userUid)
          .update({"cart": cartProds});
      // print('done updating cart');
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      // print('cart was not empty.');
      return false;
    } on PlatformException catch (_) {
      return false;
    } catch (e) {
      return false;
      // print('cart was not empty.in error');
    }

    // ! post in allOrders ... // post in Order History.
    try {
      int j = 0;
      List orderHistory = user.orders;
      for (var i in prod) {
        String orderId = const Uuid().v1();
        orderHistory.add(orderId);
        ord.Order order = ord.Order(
          sellerUid: i.sellerUid,
          category: i.category,
          desc: i.desc,
          name: i.name,
          orderDate: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
          orderId: orderId,
          payMode: "cash",
          photoUrl: i.photoUrl,
          price: (i.price * count[j]).toString(),
          quantity: count[j],
          status: "yet to be delivered",
          userAddress: addresscontroller.text.trim(),
          userId: user.userUid,
          userName: namecontroller.text.trim(),
          userPhone: phonecontroller.text.trim(),
        );
        await FirebaseFirestore.instance
            .collection('allorders')
            .doc(orderId)
            .set(
              order.toMap(),
            );

        j++;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userUid)
          .update({
        "orders": orderHistory,
      });
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      // print('not posted in all orders');
      return false;
    } on PlatformException catch (_) {
      return false;
    } catch (e) {
      return false;
      // print('not posted in all orders. in error');
    }

    // ! decrease quantity
    try {
      int j = 0;
      for (var i in prod) {
        if ((i.quantity - count[j]) == 0) {
          await FirebaseFirestore.instance
              .collection('products')
              .doc(i.id)
              .delete();
        } else {
          await FirebaseFirestore.instance
              .collection('products')
              .doc(i.id)
              .update({
            "quantity": i.quantity - count[j],
          });
        }
        j++;
      }
      // print('done decreasing quantity');
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      // print('quantity not decreased.');
      return false;
    } on PlatformException catch (_) {
      return false;
    } catch (e) {
      return false;
      // print('quantity not decreased. in error');
    }

    // ! push Notification in allOrders
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('SellerTokens');
      DocumentSnapshot documentSnapshot1 =
          await collectionReference.doc('ELO4z0WvXLgHgHSlVuagYBrunXK2').get();

      for (var i in prod) {
        DocumentSnapshot documentSnapshot2 =
            await collectionReference.doc(i.sellerUid).get();
        sendPushMessage(
          (documentSnapshot2.data() as Map<String, dynamic>)['token'],
          "You have an Order",
          "Order form ${user.userName}",
        );
      }
      sendPushMessage(
        (documentSnapshot1.data() as Map<String, dynamic>)['token'],
        "You have an Order",
        "Order form ${user.userName}",
      );
    } on FirebaseException catch (_) {
      // Caught an exception from Firebase.
      // print("Failed with error '${e.code}': ${e.message}");
      // print('push notification exception.');
      return false;
    } on PlatformException catch (_) {
      return false;
    } catch (e) {
      return false;
      // print('push notification exception. in error');
    }
    // print("all done ha ha ha....");
    return true;
  }

  void sendPushMessage(
    String token,
    String body,
    String title,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAEJpdyQU:APA91bEm3DSJuAjMvxQOXw9ITXx2C6CORljTw6AwYXtk7R3ON43qNRKt_7V_ScYZM10uObH1zvJwjxo1jT1KjIiTWOc6jLxNf2gz8zRgBr8UMgl_Uz2ckVkHikiSPlgjW8Q-eLUWfYsR',
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "dbfood"
          },
          "to": token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
        // Shared().snackbar(
        //   "Could not send notification. Please try later.",
        //   context,
        // );
      }
    }
  }
}
