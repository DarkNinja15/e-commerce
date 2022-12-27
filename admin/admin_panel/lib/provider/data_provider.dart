import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DataProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
