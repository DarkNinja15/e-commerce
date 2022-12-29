import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user/screens/Intro-Screens/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(238, 246, 250, 1.0),
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
      ),
      home: SplashScreen(),
    );
  }
}
