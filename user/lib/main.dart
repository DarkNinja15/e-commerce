import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:user/models/category_model.dart' as cate;
import 'package:user/models/product_model.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/screens/Intro-Screens/Splash_Screen.dart';
import 'package:user/services/Database_Service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(
          value: DatabaseService().products,
          initialData: const [],
        ),
        StreamProvider<List<cate.Category>>.value(
          value: DatabaseService().category,
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(238, 246, 250, 1.0),
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
