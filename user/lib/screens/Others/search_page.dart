import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:user/screens/Others/Product_info.dart';
import 'package:user/widgets/loading.dart';

import '../../models/product_model.dart';
import '../../widgets/product_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  List<Product> searchResult = [];
  List<Product> allprods = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allprods = Provider.of<List<Product>>(context);
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

  void searchquery(String query) {
    setState(() {
      searchResult = (allprods.where(
          (element) => element.name.toLowerCase().startsWith(query))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Search for Products'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 440/725,
          child: isLoading
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
                    allprods.isEmpty
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
                                child: MasonryGridView.count(
                                    shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 10,
                                    itemCount: allprods.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductInfo(
                                                prod: allprods[i],
                                              ),
                                            ),
                                          );
                                        },
                                        child: productTile(
                                            allprods[i].photoUrl,
                                            allprods[i].name,
                                            allprods[i].desc,
                                            allprods[i].price,
                                            allprods[i].discount,
                                            context
                                        ),
                                      );
                                    }),
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
                                    child: MasonryGridView.count(
                                        shrinkWrap: true,
                                        // physics:
                                        //     const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 10,
                                        itemCount: searchResult.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductInfo(
                                                    prod: searchResult[i],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: productTile(
                                                searchResult[i].photoUrl,
                                                searchResult[i].name,
                                                searchResult[i].desc,
                                                searchResult[i].price,
                                                searchResult[i].discount,
                                                context
                                            ),
                                          );
                                        }),
                                  )
                  ],
                ),
        ),
      ),
    );
  }
}
