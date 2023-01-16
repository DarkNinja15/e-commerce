// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:user/models/product_model.dart';
import 'package:user/screens/Others/Cart_Page.dart';
import 'package:user/screens/Others/Product_info.dart';
import 'package:user/screens/Others/search_page.dart';
import 'package:user/widgets/drawer.dart';
import '../../provider/user_provider.dart';
import '../../widgets/My_Widgets.dart';
import '../../widgets/product_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool isLoading = false;
  String? mtoken = '';
  List<Product> allProds = [];
  List<Product> promotedProds = [];

  // allProds contains all the products.
  // promotedProds contains all the promoted products.

  @override
  void initState() {
    // isLoading = true;
    super.initState();
    addData();
    requestPermession();
    getToken();
    initInfo();
  }

  void requestPermession() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print('User granted provisional permission.');
    } else {
      // print('User permission not granted.');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        // print('My token is $mtoken');
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('UserTokens')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );
    FlutterLocalNotificationsPlugin().initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      // print('&&&');
      // print(payload);
      try {
        if (payload != null && payload.isNotEmpty) {
          // print('Ready to navigate...');
        }
      } catch (e) {
        // print('error');
        // print(e.toString());
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      // print('**************');
      // print(
      //     'onMessage: ${remoteMessage.notification?.title} / ${remoteMessage.notification?.body}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        remoteMessage.notification!.body.toString(),
        htmlFormatTitle: true,
        contentTitle: remoteMessage.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await FlutterLocalNotificationsPlugin().show(
          0,
          remoteMessage.notification?.title,
          remoteMessage.notification?.body,
          platformChannelSpecifics,
          payload: remoteMessage.data['body']);
    });
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  void didChangeDependencies() {
    allProds = Provider.of<List<Product>>(context);
    promotedProds = allProds.where((element) => element.isPromoted).toList();
    // print(allProds.length);
    // print('..');
    // print(promotedProds.length);
    // Future.delayed(
    //     const Duration(
    //       seconds: 2,
    //     ), () {
    //   isLoading = false;
    // });
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const Drawerc(),
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/drawer.png',
                scale: 3,
              )),
          elevation: 0,
          title: const Text(
            'B H R M A R',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.search_rounded)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyCart()));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Roww(),
              SizedBox(height: 2.h),
              Roww2(context),
              SizedBox(height: 0.5.h),
              SizedBox(
                height: 33.h,
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: promotedProds.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1.1875),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductInfo(prod: promotedProds[i])));
                        },
                        child: productTile(
                            promotedProds[i].photoUrl,
                            promotedProds[i].name,
                            promotedProds[i].desc,
                            promotedProds[i].price,
                            promotedProds[i].discount,
                            context
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Container(
                  height: 4.2.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Text(
                    'All Products',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Colors.teal),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                width: double.infinity,
                child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 9.sp,
                    itemCount: allProds.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductInfo(
                                prod: allProds[i],
                              ),
                            ),
                          );
                        },
                        child: productTile(
                            allProds[i].photoUrl,
                            allProds[i].name,
                            allProds[i].desc,
                            allProds[i].price,
                            allProds[i].discount,
                            context
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
