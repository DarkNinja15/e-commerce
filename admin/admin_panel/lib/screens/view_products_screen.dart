import 'package:admin_panel/widgets/loading.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:admin_panel/widgets/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({super.key});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  List searchResult = [];
  TextEditingController controller = TextEditingController();

  void searchquery(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where(
          'name',
          // isLessThanOrEqualTo: query,
          isLessThanOrEqualTo: query.toLowerCase(),
        )
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    searchResult = [];
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.text.toString());
    // print('......');
    // print(searchResult);
    return Scaffold(
        drawer: const Drawerc(),
        appBar: AppBar(
          elevation: 0,
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: TextField(
                controller: controller,
                onChanged: (query) {
                  searchquery(query);
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
            controller.text == ''
                ? Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder: ((context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Loading();
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Image(
                              image: AssetImage(
                                'assets/void.png',
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return ProductTile(
                              snap: snapshot.data!.docs[index].data(),
                            );
                          }),
                        );
                      }),
                    ),
                  )
                : searchResult.isEmpty
                    ? Expanded(
                        child: ListView(
                          children: const [
                            Image(image: AssetImage('assets/void.png')),
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
                              return ProductTile(snap: searchResult[index]);
                            }),
                      )
          ],
        ));
  }
}
