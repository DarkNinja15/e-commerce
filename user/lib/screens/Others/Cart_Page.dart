// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/screens/Navigation_Page.dart';
import 'package:user/services/Database_Service.dart';
import 'package:user/shared/shared_properties.dart';
import 'package:user/widgets/radio_button.dart';

import '../../models/product_model.dart';
import '../../widgets/cart_nav_bar.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Product> carts = [];
  List<Product> allProds = [];
  List cartProdIds = [];
  bool isChecked = true;
  bool isLoading = false;
  int quantity = 0;

  List<int> count = [];
  List<int> isSelected = [];

  int totalcost = 0;

  void selectall(bool flag) {
    if (flag) {
      for (int i = 0; i < carts.length; i++) {
        isSelected[i] = 1;
      }
      calculate();
      setState(() {});
    }
  }

  void calculate() {
    totalcost = 0;
    for (int i = 0; i < carts.length; i++) {
      if (isSelected[i] == 1) {
        totalcost += carts[i].price.toInt() * count[i];
      }
    }
  }

  void deletefromcart(int ind, BuildContext ctx) {
    try {
      DatabaseService().addProdToCart(carts[ind].id, ctx);
      carts.removeAt(ind);
      count.removeAt(ind);
      isSelected.removeAt(ind);
      calculate();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(' A Cart item deleted successfully. '),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allProds = Provider.of<List<Product>>(context, listen: false);
    cartProdIds =
        Provider.of<UserProvider>(context, listen: false).getUser.cart;
    for (var i in cartProdIds) {
      Product p = allProds.firstWhere((element) => element.id == i);
      carts.add(p);
    }
    for (int i = 0; i < carts.length; i++) {
      count.add(1);
      isSelected.add(1);
    }
    calculate();
    super.didChangeDependencies();
  }

  //******************************************************************************

  Widget counter(int tot, int ind) {
    return Row(
      children: [
        button1(ind),
        screen(count[ind]),
        button2(tot, ind),
      ],
    );
  }

  Widget button1(int ind) {
    return GestureDetector(
      onTap: () {
        if (count[ind] > 1) {
          count[ind]--;
          calculate();
        }

        setState(() {
          quantity = count[ind];
        });
      },
      child: Container(
          margin: const EdgeInsets.all(4),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.7, color: Colors.teal),
          ),
          child: const Icon(
            Icons.remove,
            color: Colors.teal,
          )),
    );
  }

  Widget button2(int tot, int ind) {
    return GestureDetector(
      onTap: () {
        if (count[ind] < tot) {
          count[ind]++;
        } else {
          Shared().snackbar(
            'You have reached maximum product limit',
            context,
          );
        }
        calculate();
        setState(() {
          quantity = count[ind];
        });
      },
      child: Container(
          margin: const EdgeInsets.all(4),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.teal,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }

  Widget screen(int ct) {
    return Container(
        margin: const EdgeInsets.all(4),
        height: 25,
        width: 25,
        child: Center(
            child: Text(
          ct.toString(),
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        )));
  }

//****************************************************************************************

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // print(width);
    return Scaffold(
      backgroundColor: carts.isEmpty ? Colors.white : Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationPage()));
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            letterSpacing: 0.65,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: carts.isEmpty
          ? Column(
              children: const [
                Image(image: AssetImage('assets/void.png')),
                Text(
                  'Nothing to show\n\nAdd something to cart\nNow',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              selectall(isChecked);
                            });
                          },
                        ),
                        const Text(
                          'Select All Item',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.teal,
                              letterSpacing: 1),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: carts.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            margin: EdgeInsets.all(width * 0.025),
                            padding: EdgeInsets.all(width * 0.025),
                            width: width,
                            height: 125,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    child: isSelected[i] == 0
                                        ? notselectbutton()
                                        : selectbutton(),
                                  ),
                                  onTap: () {
                                    if (isSelected[i] == 0) {
                                      isSelected[i] = 1;
                                    } else {
                                      isSelected[i] = 0;
                                    }
                                    calculate();
                                    setState(() {});
                                  },
                                ),
                                Container(
                                  height: width * 0.24,
                                  width: width * 0.24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueGrey.shade200),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(carts[i].photoUrl,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: width * 0.4846,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(width: 1)
                                  // ),
                                  margin: const EdgeInsets.all(7),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        carts[i].name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.teal),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${carts[i].price.ceil().toString()} ',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            'x${count[i]} ',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.deepOrange),
                                          ),
                                          Text(
                                              '= ₹${(count[i] * carts[i].price).round()}',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.green,
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            counter(carts[i].quantity, i),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  deletefromcart(i, context);
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline_outlined,
                                                  color:
                                                      Colors.redAccent.shade200,
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Nav(
        context,
        totalcost,
        carts,
        isSelected,
        count,
      ),
    );
  }
}
