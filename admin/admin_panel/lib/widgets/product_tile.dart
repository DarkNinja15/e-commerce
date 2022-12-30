import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/screens/edit_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../shared/shared_properties.dart';

class ProductTile extends StatelessWidget {
  final Product snap;

  const ProductTile({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              Shared().deleteProduct(
                context,
                snap.id,
                snap.sellerUid,
                false,
              );
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              promoteProduct(context);
            },
            backgroundColor: const Color.fromRGBO(255, 176, 57, 1),
            foregroundColor: Colors.white,
            icon: Icons.trending_up_sharp,
            label: 'Promote',
          ),
        ],
      ),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProduct(snap: snap),
                ),
              );
            },
            // leading: Image.network(
            //   snap['photoUrl'],
            // ),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(snap.photoUrl), fit: BoxFit.fill),
              ),
            ),
            title: Text(snap.name),
            subtitle: Text(
              snap.desc,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹${snap.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                Text(
                  '  Q:${snap.quantity}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void promoteProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to promote this Product?",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "It will be listed on the front page of the user.",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.delete,
              color: Color.fromRGBO(255, 176, 57, 1),
            ),
            onPressed: () async {
              final res = await Database().promoteProduct(
                snap.id,
              );
              if (res != 'Success') {
                Shared().snackbar(
                  message: res,
                  context: context,
                );
              } else {
                Shared().snackbar(
                  message: 'Product added to promoted products.',
                  context: context,
                );
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            label: const Text(
              "Promote",
              style: TextStyle(
                color: Color.fromRGBO(255, 176, 57, 1),
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
