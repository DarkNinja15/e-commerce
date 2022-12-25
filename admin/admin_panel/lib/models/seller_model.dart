import 'dart:convert';

class Seller {
  final String name;
  final String phoneNum;
  final String address;
  final String email;
  final String type;
  Seller({
    required this.name,
    required this.phoneNum,
    required this.address,
    required this.email,
    this.type = 'seller',
  });

  Seller copyWith({
    String? name,
    String? phoneNum,
    String? address,
    String? email,
    String? type,
  }) {
    return Seller(
      name: name ?? this.name,
      phoneNum: phoneNum ?? this.phoneNum,
      address: address ?? this.address,
      email: email ?? this.email,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'phoneNum': phoneNum});
    result.addAll({'address': address});
    result.addAll({'email': email});
    result.addAll({'type': type});

    return result;
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
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
    return 'Seller(name: $name, phoneNum: $phoneNum, address: $address, email: $email, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Seller &&
        other.name == name &&
        other.phoneNum == phoneNum &&
        other.address == address &&
        other.email == email &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNum.hashCode ^
        address.hashCode ^
        email.hashCode ^
        type.hashCode;
  }
}
