import 'package:admin_panel/provider/seller_provider.dart';
import 'package:admin_panel/screens/add_seller_screen.dart';
import 'package:admin_panel/screens/edit_cattegories.dart';
import 'package:admin_panel/screens/home_page.dart';
import 'package:admin_panel/screens/promoted_products_screen.dart';
import 'package:admin_panel/screens/send_notifications.dart';
import 'package:admin_panel/screens/view_order_screen.dart';
import 'package:admin_panel/screens/view_products_screen.dart';
import 'package:admin_panel/widgets/logout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawerc extends StatelessWidget {
  const Drawerc({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Provider.of<SellerProvider>(context).getSeller;
    // print(seller);
    return seller.email == 'mybhrmar@gmail.com'
        ? Drawer(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: AssetImage('assets/logo1.png')),
                  ),
                ),
                Center(
                  child: Text(
                    'Welcome ${seller.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
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
                  title: const Text('Products'),
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
                    Icons.trending_up_sharp,
                  ),
                  title: const Text('Promoted Products'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PromotedProducts(),
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
                        builder: (context) => const ViewOrder(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.category,
                  ),
                  title: const Text('Edit Categories'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const EditCategory(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.send,
                  ),
                  title: const Text('Send Notifications'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SendNotification(),
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
                    logout(context);
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Made with love ❤️',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Drawer(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: AssetImage('assets/logo1.png')),
                  ),
                ),
                Center(
                  child: Text(
                    'Welcome ${seller.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
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
                  title: const Text('My Products'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ViewProducts(),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.person_add,
                //   ),
                //   title: const Text('Add a seller'),
                //   onTap: () {
                //     Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(
                //         builder: (context) => const AddSeller(),
                //       ),
                //     );
                //   },
                // ),
                ListTile(
                  leading: const Icon(
                    Icons.book,
                  ),
                  title: const Text('View Orders'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ViewOrder(),
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
                    logout(context);
                  },
                ),
                const Divider(),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Made with love ❤️',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  // void _signOut(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         "Are You sure You want to logout of the app?",
  //         textAlign: TextAlign.center,
  //       ),
  //       actions: <Widget>[
  //         TextButton.icon(
  //           icon: const Icon(
  //             Icons.exit_to_app,
  //             // color: Color.fromRGBO(204, 82, 88, 1),
  //           ),
  //           onPressed: () async {
  //             final res = await AuthMethods().signoutoftheapp();
  //             if (res != 'Success') {
  //               Shared().snackbar(
  //                 message: res,
  //                 context: context,
  //               );
  //             } else {
  //               // ignore: use_build_context_synchronously
  //               Navigator.of(context).pushReplacement(
  //                 MaterialPageRoute(
  //                   builder: (context) => const LoginPage(),
  //                 ),
  //               );
  //             }
  //           },
  //           label: const Text(
  //             "Log Out",
  //             style: TextStyle(
  //               // color: Color.fromRGBO(204, 82, 88, 1),
  //             ),
  //           ),
  //         ),
  //         TextButton.icon(
  //           icon: const Icon(
  //             Icons.cancel,
  //             color: Colors.grey,
  //           ),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           label: const Text(
  //             "Cancel",
  //             style: TextStyle(
  //               color: Colors.grey,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
