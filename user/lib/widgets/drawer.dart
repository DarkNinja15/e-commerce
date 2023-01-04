import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/screens/Others/order_history_screen.dart';
import 'package:user/screens/Others/terms.dart';
import 'package:user/widgets/logout.dart';

class Drawerc extends StatefulWidget {
  const Drawerc({super.key});

  @override
  State<Drawerc> createState() => _DrawercState();
}

class _DrawercState extends State<Drawerc> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
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
          Text(
            'Welcome   ${user.userName}',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              letterSpacing: 3.5,
              fontSize: 5.sp
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.history,
            ),
            title: const Text('Order History'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderHistory(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.sticky_note_2_sharp,
            ),
            title: const Text('Terms and Condition'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Terms(),
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
