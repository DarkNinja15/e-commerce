import 'package:admin_panel/screens/add_seller_screen.dart';
import 'package:admin_panel/screens/home_page.dart';
import 'package:admin_panel/screens/view_products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.view_agenda,
              ),
              title: const Text('View all Products'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ViewProducts(),
                  ),
                );
              },
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
            ListTile(
              leading: const Icon(
                Icons.book,
              ),
              title: const Text('View Orders'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AddSeller(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.book,
              ),
              title: const Text('LogOut'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Navigator
              },
            ),
          ],
        ),
      ),
    );
  }
}
