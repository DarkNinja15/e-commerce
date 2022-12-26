import 'package:admin_panel/screens/edit_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../shared/shared_properties.dart';

class ProductTile extends StatelessWidget {
  final dynamic snap;

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
                snap['id'],
                snap['sellerUid'],
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.edit,
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProduct(snap: snap),
                ),
              );
            },
            backgroundColor: const Color.fromRGBO(204, 82, 88, 1),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProduct(snap: snap),
              ),
            );
          },
          leading: Image.network(
            snap['photoUrl'],
          ),
          title: Text(snap['name']),
          subtitle: Text(snap['desc']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${snap['price']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '  Q:${snap['quantity']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
