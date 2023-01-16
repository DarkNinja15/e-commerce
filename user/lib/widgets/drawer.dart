import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:user/models/user_model.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/screens/Others/order_history_screen.dart';
import 'package:user/screens/Others/terms.dart';
import 'package:user/services/Auth_Service.dart';
import 'package:user/services/Database_Service.dart';
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
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/logo1.png')),
            ),
          ),
          SizedBox(height: 10.sp),
          Text(
            'Welcome   ${user?.userName}',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              letterSpacing: 3.5,
              fontSize: 11.sp
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.history,
              size: 17.sp,
            ),
            title: Text('Order History', style: TextStyle(fontSize: 10.sp, color: Colors.blueGrey),),
            trailing: Icon(Icons.arrow_forward_ios, size: 12.sp,),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderHistory(),
                ),
              );
            },
          ),
          SizedBox(height: 7.sp),
          ListTile(
            leading: Icon(
              Icons.sticky_note_2_sharp,
              size: 17.sp,
            ),
            title: Text('Terms and Condition', style: TextStyle(fontSize: 10.sp, color: Colors.blueGrey),),
            trailing: Icon(Icons.arrow_forward_ios, size: 12.sp,),

            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Terms(),
                ),
              );
            },
          ),
          SizedBox(height: 7.sp),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 17.sp,
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 12.sp,),
            title:Text('LogOut', style: TextStyle(fontSize: 10.sp, color: Colors.blueGrey),),
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
