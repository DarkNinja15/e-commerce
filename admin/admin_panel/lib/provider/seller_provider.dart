import 'package:admin_panel/models/seller_model.dart';
import 'package:flutter/material.dart';

import '../auth&database/authmethods.dart';

class SellerProvider with ChangeNotifier {
  Seller? _user;
  final AuthMethods _authMethods = AuthMethods();
  Seller get getSeller => _user!;

  Future<void> refreshUser() async {
    Seller user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
