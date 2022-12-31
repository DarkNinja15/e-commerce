import 'package:flutter/material.dart';
import 'package:user/services/Auth_Service.dart';

class Drawerc extends StatefulWidget {
  const Drawerc({super.key});

  @override
  State<Drawerc> createState() => _DrawercState();
}

class _DrawercState extends State<Drawerc> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/logo1.png')),
            ),
          ),
          // Text(
          //   'Welcome ${seller.name}',
          //   style: const TextStyle(fontWeight: FontWeight.bold),
          // ),
          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text('LogOut'),
            onTap: () {
              Authentication.signOut(
                context: context,
              );
            },
          ),
          const Divider(),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Made with love ❤️',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
