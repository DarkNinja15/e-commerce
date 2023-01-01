// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/screens/Others/Cart_Page.dart';
import 'package:user/screens/Others/Product_info.dart';
import 'package:user/widgets/drawer.dart';
import '../provider/user_provider.dart';
import '../widgets/My_Widgets.dart';
import '../widgets/product_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool isLoading = false;
  List<Product> allProds = [];
  List<Product> promotedProds = [];

  // allProds contains all the products.
  // promotedProds contains all the promoted products.

  @override
  void initState() {
    // isLoading = true;
    super.initState();
    addData();
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  void didChangeDependencies() {
    allProds = Provider.of<List<Product>>(context);
    promotedProds = allProds.where((element) => element.isPromoted).toList();
    // print(allProds.length);
    // print('..');
    // print(promotedProds.length);
    // Future.delayed(
    //     const Duration(
    //       seconds: 2,
    //     ), () {
    //   isLoading = false;
    // });
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const Drawerc(),
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/drawer.png',
                scale: 3,
              )),
          elevation: 0,
          title: const Text(
            'B H R M A R',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyCart()));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Roww(),
              const SizedBox(height: 16),
              Roww2(context),
              const SizedBox(height: 5),
              SizedBox(
                height: 230,
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: promotedProds.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1.1875),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductInfo(prod: promotedProds[i])));
                        },
                        child: productTile(
                            promotedProds[i].photoUrl,
                            promotedProds[i].name,
                            promotedProds[i].desc,
                            promotedProds[i].price,
                            promotedProds[i].discount),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 35,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: const Text(
                    'All Products',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.teal),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                width: double.infinity,
                child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 10,
                    itemCount: allProds.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductInfo(prod: allProds[i])));
                        },
                        child: productTile(
                            allProds[i].photoUrl,
                            allProds[i].name,
                            allProds[i].desc,
                            allProds[i].price,
                            allProds[i].discount),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
