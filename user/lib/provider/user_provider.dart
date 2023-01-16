import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/models/user_model.dart';
import 'package:user/services/Auth_Service.dart';

import '../services/Database_Service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    await DatabaseService(uid: uid).getUserData().then((value) {
      _user = UserModel.fromMap(value);
    });
    notifyListeners();
  }
}
