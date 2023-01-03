// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/widgets/loading.dart';

import '../../widgets/product_tile.dart';
import 'Product_info.dart';

class CategoryDetail extends StatefulWidget {
  final String name;
  final String picUrl;
  const CategoryDetail({super.key, required this.name, required this.picUrl});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  bool isLoading = false;
  List<Product> catProds = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    catProds = Provider.of<List<Product>>(context)
        .where((element) => element.category == widget.name)
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

  Widget Tile() {
    return Container(
      height: 145,
      width: 335,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.yellow),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          widget.picUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // catProds contains
    // catthe products related to that category.
    // print(catProds);

    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              elevation: 0,
              title: Text(
                widget.name,
                style: const TextStyle(
                    letterSpacing: 1.2, fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Tile(),
                  catProds.isEmpty
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
                      : SizedBox(
                          width: double.infinity,
                          child: MasonryGridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 10,
                              itemCount: catProds.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductInfo(
                                                prod: catProds[i])));
                                  },
                                  child: productTile(
                                      catProds[i].photoUrl,
                                      catProds[i].name,
                                      catProds[i].desc,
                                      catProds[i].price,
                                      catProds[i].discount),
                                );
                              }),
                        ),
                ],
              ),
            ),
          );
  }
}
