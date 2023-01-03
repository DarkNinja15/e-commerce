import 'dart:convert';

import 'package:admin_panel/shared/shared_properties.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/drawer.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  bool sendtosellers = true;

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    contentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawerc(),
      appBar: AppBar(
        title: const Text('Send Notifications'),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'To sellers', 'To Users'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: TextField(
              controller: titlecontroller,
              style: const TextStyle(),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                // filled: true,
                hintText: "Title of Notification",
                icon: const Icon(
                  Icons.title,
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
              controller: contentcontroller,
              style: const TextStyle(),
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                // filled: true,
                hintText: "Content",
                icon: const Icon(
                  Icons.note_alt_sharp,
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
          InkWell(
            onTap: _notificationSender,
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
                  'Send Notification',
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
    );
  }

  void _notificationSender() async {
    // print("sendtosellers");
    // print(sendtosellers);
    if (sendtosellers) {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('SellerTokens');
      QuerySnapshot querySnapshot = await collectionReference.get();
      final allData = querySnapshot.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();
      // print(allData[0]['token']);
      for (var i in allData) {
        sendPushMessage(
          i['token'],
          contentcontroller.text,
          titlecontroller.text,
        );
      }
    } else {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('UserTokens');
      QuerySnapshot querySnapshot = await collectionReference.get();
      final allData = querySnapshot.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();
      // print(allData[0]['token']);
      for (var i in allData) {
        sendPushMessage(
          i['token'],
          contentcontroller.text,
          titlecontroller.text,
        );
      }
    }

    contentcontroller.text = "";
    titlecontroller.text = "";
    Shared().snackbar(
      message: "Notification sent successfully.",
      context: context,
    );
    // print("....done");
  }

  void sendPushMessage(
    String token,
    String body,
    String title,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAEJpdyQU:APA91bEm3DSJuAjMvxQOXw9ITXx2C6CORljTw6AwYXtk7R3ON43qNRKt_7V_ScYZM10uObH1zvJwjxo1jT1KjIiTWOc6jLxNf2gz8zRgBr8UMgl_Uz2ckVkHikiSPlgjW8Q-eLUWfYsR',
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "dbfood"
          },
          "to": token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
        Shared().snackbar(
          message: "Could not send notification. Please try later.",
          context: context,
        );
      }
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'To sellers':
        setState(() {
          sendtosellers = true;
        });
        break;
      case 'To Users':
        setState(() {
          sendtosellers = false;
        });
        break;
    }
  }
}
