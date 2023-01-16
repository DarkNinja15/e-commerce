// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/Shared_Pref.dart';
import '../navigation_bar_pages/Navigation_Page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSignedIn = false;

  void fun(BuildContext ctx) {
    Timer(const Duration(seconds: 3), () {
      if (isSignedIn) {
        Navigator.pushReplacement(ctx,
            MaterialPageRoute(builder: (context) => const NavigationPage()));
      } else {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fun(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
