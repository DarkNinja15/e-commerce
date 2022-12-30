import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/widgets/loading.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:admin_panel/widgets/product_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({super.key});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  List<Product> searchResult = [];
  TextEditingController controller = TextEditingController();
  List<Product> myprods = [];
  List<Product> allprods = [];
  bool isLoading = false;
  bool isAllProdselcted = false;

  void searchquery(String query) {
    if (!isAllProdselcted) {
      setState(() {
        searchResult = (myprods.where(
                (element) => element.name.toLowerCase().startsWith(query)))
            .toList();
      });
    } else {
      setState(() {
        searchResult = (allprods.where(
                (element) => element.name.toLowerCase().startsWith(query)))
            .toList();
      });
    }
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    searchResult = [];
  }

  @override
  void didChangeDependencies() {
    allprods = Provider.of<List<Product>>(context);
    myprods = allprods
        .where((element) =>
            element.sellerUid == FirebaseAuth.instance.currentUser!.uid)
        .toList();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      setState(() {
        isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('......');
    // print(prods);
    // print(controller.text.toString());
    // print(searchResult);
    return Scaffold(
      drawer: const Drawerc(),
      appBar: AppBar(
        elevation: 0,
        title: isAllProdselcted
            ? const Text('All Products')
            : const Text('My Products'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'All Products', 'My Products'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Loading()
          : Column(
              children: [
                Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: TextField(
                    controller: controller,
                    onChanged: (query) {
                      searchquery(query.toLowerCase());
                    },
                    style: const TextStyle(),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search for a Product",
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                !isAllProdselcted
                    ? myprods.isEmpty
                        ? Column(
                            children: const [
                              Image(
                                image: AssetImage(
                                  'assets/void.png',
                                ),
                              ),
                              Text(
                                'Nothing to Show',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 33,
                                ),
                              ),
                            ],
                          )
                        : controller.text == ''
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: myprods.length,
                                  itemBuilder: (context, index) {
                                    return ProductTile(
                                      snap: myprods[index],
                                    );
                                  },
                                ),
                              )
                            : searchResult.isEmpty
                                ? Expanded(
                                    child: ListView(
                                      children: const [
                                        Image(
                                          image: AssetImage(
                                            'assets/void.png',
                                          ),
                                        ),
                                        Text(
                                          'Nothing to Show',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 33,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchResult.length,
                                        itemBuilder: (context, index) {
                                          // print(searchResult[index]['name']);
                                          return ProductTile(
                                            snap: searchResult[index],
                                          );
                                        }),
                                  )
                    : allprods.isEmpty
                        ? Column(
                            children: const [
                              Image(
                                image: AssetImage(
                                  'assets/void.png',
                                ),
                              ),
                              Text(
                                'Nothing to Show',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 33,
                                ),
                              ),
                            ],
                          )
                        : controller.text == ''
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: allprods.length,
                                  itemBuilder: (context, index) {
                                    return ProductTile(
                                      snap: allprods[index],
                                    );
                                  },
                                ),
                              )
                            : searchResult.isEmpty
                                ? Expanded(
                                    child: ListView(
                                      children: const [
                                        Image(
                                          image: AssetImage(
                                            'assets/void.png',
                                          ),
                                        ),
                                        Text(
                                          'Nothing to Show',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 33,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchResult.length,
                                        itemBuilder: (context, index) {
                                          // print(searchResult[index]['name']);
                                          return ProductTile(
                                            snap: searchResult[index],
                                          );
                                        }),
                                  ),
              ],
            ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'All Products':
        setState(() {
          isAllProdselcted = true;
        });
        break;
      case 'My Products':
        setState(() {
          isAllProdselcted = false;
        });
        break;
    }
  }
}



// alternative of streamProvider
// StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('products')
//                           .snapshots(),
//                       builder: ((context,
//                           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                               snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Loading();
//                         }
//                         if (snapshot.data!.docs.isEmpty) {
//                           return const Center(
//                             child: Image(
//                               image: AssetImage(
//                                 'assets/void.png',
//                               ),
//                             ),
//                           );
//                         }
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: ((context, index) {
//                             return ProductTile(
//                               snap: snapshot.data!.docs[index].data(),
//                             );
//                           }),
//                         );
//                       }),
//                     ),
