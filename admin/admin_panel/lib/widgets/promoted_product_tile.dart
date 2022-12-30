import 'package:admin_panel/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../auth&database/database.dart';
import '../models/product_model.dart';
import '../shared/shared_properties.dart';

class PromotedProductTile extends StatelessWidget {
  final Product snap;
  const PromotedProductTile({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    Seller seller = (Provider.of<List<Seller>>(context)
        .where((element) => element.uid == snap.sellerUid)
        .toList())[0];
    // print(seller);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              removefrompromoted(context);
            },
            foregroundColor: Colors.black,
            label: 'phone: ${seller.phoneNum}',
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
              removefrompromoted(context);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.remove_circle_outline,
            label: 'Remove from promoted products',
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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => EditProduct(snap: snap),
              //   ),
              // );
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
              'sold by: ${seller.name}',
              overflow: TextOverflow.visible,
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

  void removefrompromoted(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to promote this Product?",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "It will be unlisted on the front page of the user.",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.trending_neutral_sharp,
              color: Color.fromRGBO(255, 176, 57, 1),
            ),
            onPressed: () async {
              final res = await Database().demoteProduct(
                snap.id,
              );
              if (res != 'Success') {
                Shared().snackbar(
                  message: res,
                  context: context,
                );
              } else {
                Shared().snackbar(
                  message: 'Product removed from promoted products.',
                  context: context,
                );
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            label: const Text(
              "Remove",
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
