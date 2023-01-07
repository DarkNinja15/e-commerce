import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user/models/category_model.dart' as cate;
import 'package:user/models/order_model.dart' as ord;
import 'package:user/models/product_model.dart';
import 'package:user/provider/user_provider.dart';
import 'package:user/screens/Intro-Screens/Splash_Screen.dart';
import 'package:user/services/Database_Service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'package:sizer/sizer.dart';

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  // print('Handling a background message ${remoteMessage.messageId}');
}

void main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        StreamProvider<List<ord.Order>>.value(
          value: DatabaseService().order,
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: Sizer(
          builder: (context, orientation, deviceType){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: const Color.fromRGBO(238, 246, 250, 1.0),
                brightness: Brightness.light,
                primarySwatch: Colors.teal,
                primaryColor: Colors.teal,
              ),
              home: const SplashScreen(),
            );
      }),
    );
  }
}
