import 'package:flutter/material.dart';
import 'package:user/models/user_model.dart';
import 'package:user/services/Auth_Service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final Authentication _authentication = Authentication();
  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _authentication.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
