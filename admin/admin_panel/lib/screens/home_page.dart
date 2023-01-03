import 'dart:typed_data';
import 'package:admin_panel/auth&database/database.dart';
import 'package:admin_panel/provider/seller_provider.dart';
import 'package:admin_panel/widgets/loading.dart';
import 'package:admin_panel/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../shared/shared_properties.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  Uint8List? image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController dplcontroller = TextEditingController();
  List<DropdownMenuItem<String>> items = [];
  bool f = true;
  String? mtoken = '';

  @override
  void initState() {
    addData();
    super.initState();
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
        .collection('SellerTokens')
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
    await Provider.of<SellerProvider>(context, listen: false).refreshUser();
  }

  String selectedCattegory = "Others";

  _selectImage() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select the path"),
        content:
            const Text("Choose the path from where you want to pick the image"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              Uint8List im = await Shared().imagepicker(ImageSource.camera);
              setState(() {
                image = im;
              });
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              Uint8List im = await Shared().imagepicker(ImageSource.gallery);
              setState(() {
                image = im;
              });
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    pricecontroller.dispose();
    desccontroller.dispose();
    quantitycontroller.dispose();
    dplcontroller.dispose();
    discountcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Product> abc = Provider.of<List<Product>>(context);
    // final seller = Provider.of<SellerProvider>(context).getSeller;
    if (f) {
      List<String> abs = Provider.of<List<String>>(context);
      for (var i = 0; i < abs.length; i++) {
        items.add(
          DropdownMenuItem(
            value: abs[i],
            child: Text(
              abs[i],
            ),
          ),
        );
      }
      f = false;
      // print('...');
      // print(abs);
    }

    final size =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // print(MediaQuery.of(context).size.width);
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            drawer: const Drawerc(),
            appBar: AppBar(
              title: const Text('Add a Product'),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.5,
                        color: const Color.fromRGBO(255, 176, 57, 1),
                      ),
                    ),
                    height: size * 0.35,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.width * 0.05),
                    child: image == null
                        ? const Image(
                            image: AssetImage('assets/icon_img.png'),
                            fit: BoxFit.contain,
                          )
                        : Image(
                            image: MemoryImage(
                              image!,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add a photo',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              const Color.fromRGBO(255, 176, 57, 1),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: _selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: namecontroller,
                      style: const TextStyle(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Name of the Product",
                        icon: const Icon(
                          Icons.shop_2,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: desccontroller,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(),
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Product description",
                        icon: const Icon(
                          Icons.notes,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: pricecontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Set Price",
                        icon: const Icon(
                          Icons.price_check,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: quantitycontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Quantitiy",
                        icon: const Icon(
                          Icons.production_quantity_limits_outlined,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: discountcontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Enter Discount(%)",
                        icon: const Icon(
                          Icons.discount,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      controller: dplcontroller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        // filled: true,
                        hintText: "Discount Product limit",
                        icon: const Icon(
                          Icons.label_outline,
                          // color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Cattegory',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton(
                          value: selectedCattegory,
                          items: items,
                          onChanged: (value) {
                            setState(() {
                              selectedCattegory = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _addProd,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 176, 57, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.width * 0.05),
                      child: const Center(
                        child: Text(
                          'Add Product to Database',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void _addProd() async {
    if (namecontroller.text.isEmpty ||
        desccontroller.text.isEmpty ||
        pricecontroller.text.isEmpty ||
        image == null ||
        quantitycontroller.text.isEmpty ||
        discountcontroller.text.isEmpty ||
        dplcontroller.text.isEmpty) {
      Shared().snackbar(
        message: "Please Enter all the details.",
        context: context,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    final res = await Database().addProduct(
      namecontroller.text.trim(),
      desccontroller.text.trim(),
      pricecontroller.text.trim(),
      image,
      int.parse(quantitycontroller.text.trim()),
      double.parse(discountcontroller.text.trim()),
      int.parse(dplcontroller.text.trim()),
      FirebaseAuth.instance.currentUser!.uid,
      selectedCattegory,
    );
    setState(() {
      namecontroller.text = "";
      desccontroller.text = "";
      pricecontroller.text = "";
      discountcontroller.text = "";
      dplcontroller.text = "";
      quantitycontroller.text = "";
      image = null;
      isLoading = false;
    });
    if (res != "Success") {
      Shared().snackbar(
        message: res,
        context: context,
      );
    } else {
      Shared().snackbar(
        message: "Product added to database",
        context: context,
      );
    }
  }
}
