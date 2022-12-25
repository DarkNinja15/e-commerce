import 'package:admin_panel/screens/add_seller_screen.dart';
import 'package:flutter/material.dart';

class Drawerc extends StatelessWidget {
  const Drawerc({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(
                Icons.shopping_bag_outlined,
              ),
              title: const Text('Add a Product'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.view_agenda,
              ),
              title: const Text('View all Products'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add,
              ),
              title: const Text('Add a seller'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AddSeller(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
