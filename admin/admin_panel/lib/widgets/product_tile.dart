import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final dynamic snap;

  const ProductTile({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Image.network(
          snap['photoUrl'],
        ),
        title: Text(snap['name']),
        subtitle: Text(snap['desc']),
      ),
    );
  }
}
