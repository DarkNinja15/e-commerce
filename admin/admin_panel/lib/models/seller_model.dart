import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String uid;
  final String name;
  final String phoneNum;
  final String address;
  final String email;
  final String type;
  Seller({
    required this.uid,
    required this.name,
    required this.phoneNum,
    required this.address,
    required this.email,
    this.type = 'seller',
  });

  Seller copyWith({
    String? uid,
    String? name,
    String? phoneNum,
    String? address,
    String? email,
    String? type,
  }) {
    return Seller(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNum: phoneNum ?? this.phoneNum,
      address: address ?? this.address,
      email: email ?? this.email,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'name': name});
    result.addAll({'phoneNum': phoneNum});
    result.addAll({'address': address});
    result.addAll({'email': email});
    result.addAll({'type': type});

    return result;
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phoneNum: map['phoneNum'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Seller.fromJson(String source) => Seller.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Seller(uid: $uid, name: $name, phoneNum: $phoneNum, address: $address, email: $email, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Seller &&
        other.uid == uid &&
        other.name == name &&
        other.phoneNum == phoneNum &&
        other.address == address &&
        other.email == email &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        phoneNum.hashCode ^
        address.hashCode ^
        email.hashCode ^
        type.hashCode;
  }

  static Seller fromSnap(DocumentSnapshot snap) {
    // print('snap');
    // print(snap.data());
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return Seller(
      uid: snapshot['uid'],
      name: snapshot['name'],
      phoneNum: snapshot['phoneNum'],
      address: snapshot['address'],
      email: snapshot['email'],
      type: snapshot['type'],
    );
  }
}
