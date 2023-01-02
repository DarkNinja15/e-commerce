import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/order_model.dart' as ord;
import 'package:user/widgets/loading.dart';

import '../../provider/user_provider.dart';
import '../../widgets/drawer.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool isLoading = false;
  List<ord.Order> allOrders = [];

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

  @override
  Widget build(BuildContext context) {
    // print(allOrders);
    // allOrders contains all the previous orders of user.
    return Scaffold(
      drawer: const Drawerc(),
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : Container(
              // remove this container and add all order history....
              ),
    );
  }
}
