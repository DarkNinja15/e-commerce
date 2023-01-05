// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
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
          height: 3.h,
          width: 3.h,
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
          height: 3.h,
          width: 3.h,
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
        height: 3.h,
        width: 3.h,
        child: Center(
            child: Text(
          ct.toString(),
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        )));
  }

  Widget deletebutton(int i){
    return  IconButton(
        onPressed: () {
          deletefromcart(i, context);
        },
        icon: Icon(
          Icons.delete_outline_outlined,
          color:
              Colors.redAccent.shade200,
        ));
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
      body: Container(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 440/725,
          child: carts.isEmpty
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
                                margin: EdgeInsets.all(width * 0.020),
                                padding: EdgeInsets.all(width * 0.020),
                                width: width,
                                height: 15.h,
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
                                    SizedBox(width: 1.w,),
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
                                    SizedBox(width: 1.w),
                                    Container(
                                      margin: const EdgeInsets.all(7),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width*0.49,
                                            child: Text(
                                              carts[i].name,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '₹${carts[i].price.ceil().toString()} ',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.green),
                                              ),
                                              Text(
                                                'x${count[i]} ',
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.deepOrange),
                                              ),
                                              Text(
                                                  '= ₹${(count[i] * carts[i].price).round()}',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.green,
                                                      overflow:
                                                          TextOverflow.ellipsis))
                                            ],
                                          ),
                                         Container(
                                           width: width*0.49,

                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceBetween,
                                             children: [
                                               counter(carts[i].quantity, i),
                                               deletebutton(i),
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
