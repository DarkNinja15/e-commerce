import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
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
        drawer: Drawer(),
        appBar: AppBar(
          leading: InkWell(
              onTap: (){_scaffoldKey.currentState?.openDrawer();},
              child: Image.asset('assets/drawer.png', scale: 3,)),
          elevation: 0,
          title: const Text('B H R M A R', style: TextStyle(fontWeight: FontWeight.w400),),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/home/1.png'),
                  Image.asset('assets/home/2.png'),
                  Image.asset('assets/home/3.png'),
                  Image.asset('assets/home/4.png'),
                  Image.asset('assets/home/5.png'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 25,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Featured Product', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.teal, fontSize: 17),),
                  Text('See All', style: TextStyle(color: Color.fromRGBO(255, 176, 57, 1) ),)
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 230,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: promotedProds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1.1875),
                  itemBuilder: (context, i){
                      return productTile(promotedProds[i].photoUrl, promotedProds[i].name, promotedProds[i].desc, promotedProds[i].price, promotedProds[i].discount);
                  }
              ),
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: const Text('All Products', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.teal), textAlign: TextAlign.start,)),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 10,
                  itemCount: allProds.length,
                  itemBuilder: (context, i){
                    return productTile(allProds[i].photoUrl, allProds[i].name, allProds[i].desc, allProds[i].price, allProds[i].discount);
                  }
              ),
            )
          ],
        ),
      )
    );
  }
}
