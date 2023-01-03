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
    var width = MediaQuery.of(context).size.width;
    print(allOrders);
    // allOrders contains all the previous orders of user.
    return Scaffold(
      drawer: const Drawerc(),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        title: const Text('Order History', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400),),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : ListView.builder(
              itemCount: allOrders.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){
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
                      allOrders[i].status
                  ),
                );
              }),
    );
  }
}
