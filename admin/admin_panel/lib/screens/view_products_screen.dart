import 'package:admin_panel/shared/loading.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:admin_panel/widgets/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewProducts extends StatelessWidget {
  const ViewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawerc(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: ((context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                      }));
                }),
              ),
            ),
          ],
        ));
  }
}
