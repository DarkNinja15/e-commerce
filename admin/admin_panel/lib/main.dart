import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/models/order_model.dart';
import 'package:admin_panel/models/product_model.dart';
import 'package:admin_panel/screens/home_page.dart';
import 'package:admin_panel/screens/login_page.dart';
import 'package:admin_panel/screens/splash_screen.dart';
import 'package:admin_panel/widgets/loading.dart';
import 'package:admin_panel/shared/shared_properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          value: Database().products,
          initialData: const [],
        ),
        StreamProvider<List<Order>>.value(
          value: Database().orders,
          initialData: const [],
        ),
        FutureProvider<List<String>>.value(
          value: Database().cattegories,
          initialData: const [],
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const SplashScreen(
                  widget: HomePage(),
                );
              } else if (snapshot.hasError) {
                Shared().snackbar(
                  message: 'Some Error Occured',
                  context: context,
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Loading(),
              );
            }
            return const SplashScreen(
              widget: LoginPage(),
            );
          }),
        ),
      ),
    );
  }
}
