import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String userUid;
  final String userName;
  final String phoneNo;
  final String profilePicUrl;
  final String email;
  final String address;
  final List cart;
  final List wishlist;
  final List orders;

  UserModel({
    required this.userUid,
    required this.userName,
    required this.phoneNo,
    this.profilePicUrl = '',
    required this.email,
    required this.address,
    this.cart = const [],
    this.wishlist = const [],
    this.orders = const [],
  });

  UserModel copyWith({
    String? userUid,
    String? userName,
    String? phoneNo,
    String? profilePicUrl,
    String? email,
    String? address,
    List? cart,
    List? wishlist,
    List? orders,
  }) {
    return UserModel(
      userUid: userUid ?? this.userUid,
      userName: userName ?? this.userName,
      phoneNo: phoneNo ?? this.phoneNo,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      email: email ?? this.email,
      address: address ?? this.address,
      cart: cart ?? this.cart,
      wishlist: wishlist ?? this.wishlist,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userUid': userUid});
    result.addAll({'userName': userName});
    result.addAll({'phoneNo': phoneNo});
    result.addAll({'profilePicUrl': profilePicUrl});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'cart': cart});
    result.addAll({'wishlist': wishlist});
    result.addAll({'orders': orders});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userUid: map['userUid'] ?? '',
      userName: map['userName'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      cart: List.from(map['cart']),
      wishlist: List.from(map['wishlist']),
      orders: List.from(map['orders']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userUid: $userUid, userName: $userName, phoneNo: $phoneNo, profilePicUrl: $profilePicUrl, email: $email, address: $address, cart: $cart, wishlist: $wishlist, orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userUid == userUid &&
        other.userName == userName &&
        other.phoneNo == phoneNo &&
        other.profilePicUrl == profilePicUrl &&
        other.email == email &&
        other.address == address &&
        listEquals(other.cart, cart) &&
        listEquals(other.wishlist, wishlist) &&
        listEquals(other.orders, orders);
  }

  @override
  int get hashCode {
    return userUid.hashCode ^
        userName.hashCode ^
        phoneNo.hashCode ^
        profilePicUrl.hashCode ^
        email.hashCode ^
        address.hashCode ^
        cart.hashCode ^
        wishlist.hashCode ^
        orders.hashCode;
  }
}
