import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/order_model.dart' as ord;
import 'package:user/screens/Others/Order_Detail.dart';
import 'package:user/widgets/loading.dart';
import 'package:user/widgets/order_tile.dart';

import '../../provider/user_provider.dart';
import '../../widgets/drawer.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool isLoading = false;
  bool isDelivered = false;
  List<ord.Order> allOrders = [];
  List<ord.Order> deliverdOrders = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final user = Provider.of<UserProvider>(context).getUser;
    allOrders = Provider.of<List<ord.Order>>(context)
        .where((element) => element.userId == user.userUid)
        .toList();
    deliverdOrders =
        allOrders.where((element) => element.status == 'delivered').toList();
    // print("....");
    // print(deliverdOrders);
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  void handleClick(String value) {
    switch (value) {
      case 'All Products':
        setState(() {
          isDelivered = false;
        });
        break;
      case 'Delivered':
        setState(() {
          isDelivered = true;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // print(deliverdOrders);
    // allOrders contains all the previous orders of user.
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawerc(),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          elevation: 0,
          title: const Text(
            'Order History',
            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'All Products', 'Delivered'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: isLoading
            ? const Loading()
            : !isDelivered
                ? allOrders.isEmpty
                    ? Column(
                        children: const [
                          Image(image: AssetImage('assets/void.png')),
                          Text(
                            'Nothing to show',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 33),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: allOrders.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderDetail(snap: allOrders[i])));
                            },
                            child: Order_tile(
                                width,
                                allOrders[i].photoUrl,
                                allOrders[i].name,
                                allOrders[i].price,
                                allOrders[i].quantity.toString(),
                                allOrders[i].status),
                          );
                        })
                : deliverdOrders.isEmpty
                    ? Column(
                        children: const [
                          Image(image: AssetImage('assets/void.png')),
                          Text(
                            'Nothing to show',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 33),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: deliverdOrders.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetail(
                                          snap: deliverdOrders[i])));
                            },
                            child: Order_tile(
                                width,
                                deliverdOrders[i].photoUrl,
                                deliverdOrders[i].name,
                                deliverdOrders[i].price,
                                deliverdOrders[i].quantity.toString(),
                                deliverdOrders[i].status),
                          );
                        }));
  }
}
