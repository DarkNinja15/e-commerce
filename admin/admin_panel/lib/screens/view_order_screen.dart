import 'package:admin_panel/models/order_model.dart' as od;
import 'package:admin_panel/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/loading.dart';
import '../widgets/order_tile.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  List<od.Order> searchResult = [];
  TextEditingController controller = TextEditingController();
  List<od.Order> ord = [];
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didChangeDependencies() {
    ord = Provider.of<List<od.Order>>(context);
    // print('ord');
    // print(ord);
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

  void searchquery(String query) {
    setState(() {
      searchResult =
          (ord.where((element) => element.name.toLowerCase().startsWith(query)))
              .toList();
    });
    // print(searchResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawerc(),
        appBar: AppBar(
          title: const Text('Pending Orders'),
          centerTitle: true,
          elevation: 0,
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
                        // print(query);
                        searchquery(query.toLowerCase());
                      },
                      style: const TextStyle(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search for an Order",
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
                  ord.isEmpty
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
                                itemCount: ord.length,
                                itemBuilder: (context, index) {
                                  return OrderTile(
                                    snap: ord[index],
                                  );
                                },
                              ),
                            )
                          : searchResult.isEmpty
                              ? Expanded(
                                  child: Column(
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
                                    // shrinkWrap: true,
                                    itemCount: searchResult.length,
                                    itemBuilder: (context, index) {
                                      // print(searchResult[index]);
                                      // print('searchResult[index]');
                                      return OrderTile(
                                          snap: searchResult[index]);
                                    },
                                  ),
                                )
                ],
              ));
  }
}


// alternative for stream provider
// StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('allorders')
//                           .snapshots(),
//                       builder: ((context,
//                           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                               snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Loading();
//                         }
//                         if (snapshot.data!.docs.isEmpty) {
//                           return Column(children: const [
//                             Image(
//                               image: AssetImage(
//                                 'assets/void.png',
//                               ),
//                             ),
//                             Text(
//                               'Nothing to Show',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 33,
//                               ),
//                             ),
//                           ]);
//                         }
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: ((context, index) {
//                             return OrderTile(
//                               snap: snapshot.data!.docs[index].data(),
//                             );
//                           }),
//                         );
//                       }),
//                     ),
