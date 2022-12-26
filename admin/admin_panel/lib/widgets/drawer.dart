import 'package:admin_panel/auth&database/authmethods.dart';
import 'package:admin_panel/screens/add_seller_screen.dart';
import 'package:admin_panel/screens/home_page.dart';
import 'package:admin_panel/screens/login_page.dart';
import 'package:admin_panel/screens/view_products_screen.dart';
import 'package:admin_panel/shared/shared_properties.dart';
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
                    builder: (context) => const ViewProducts(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: const Text('LogOut'),
              onTap: () {
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You sure You want to logout of the app?",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.exit_to_app,
              color: Color.fromRGBO(204, 82, 88, 1),
            ),
            onPressed: () async {
              final res = await AuthMethods().signoutoftheapp();
              if (res != 'Success') {
                Shared().snackbar(
                  message: res,
                  context: context,
                );
              } else {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
            label: const Text(
              "Log Out",
              style: TextStyle(
                color: Color.fromRGBO(204, 82, 88, 1),
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
