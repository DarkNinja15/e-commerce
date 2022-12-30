// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/provider/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    // print(user);
    // this user contains the current user which is logged in.
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Your Profile',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
                color: Colors.teal),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //     image: NetworkImage(url),
                  //     fit: BoxFit.fill
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Rishi Raj + ${user.userName}',
                style: const TextStyle(
                  fontSize: 30,
                  // color: Colors.white
                ),
              ),
            ],
          ),
        ));
  }
}
