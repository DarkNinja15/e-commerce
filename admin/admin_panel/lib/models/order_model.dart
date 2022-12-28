import 'dart:convert';

class Order {
  final String userId;
  final String orderId;
  final String name;
  final String price;
  final String userName;
  final String userAddress;
  final String userPhone;
  final DateTime orderDate;
  final String status;
  final int quantity;
  final String category;
  final String desc;
  Order({
    required this.userId,
    required this.orderId,
    required this.name,
    required this.price,
    required this.userName,
    required this.userAddress,
    required this.userPhone,
    required this.orderDate,
    required this.status,
    required this.quantity,
    required this.category,
    required this.desc,
  });

  Order copyWith({
    String? userId,
    String? orderId,
    String? name,
    String? price,
    String? userName,
    String? userAddress,
    String? userPhone,
    DateTime? orderDate,
    String? status,
    int? quantity,
    String? category,
    String? desc,
  }) {
    return Order(
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      name: name ?? this.name,
      price: price ?? this.price,
      userName: userName ?? this.userName,
      userAddress: userAddress ?? this.userAddress,
      userPhone: userPhone ?? this.userPhone,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'orderId': orderId});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'userName': userName});
    result.addAll({'userAddress': userAddress});
    result.addAll({'userPhone': userPhone});
    result.addAll({'orderDate': orderDate.millisecondsSinceEpoch});
    result.addAll({'status': status});
    result.addAll({'quantity': quantity});
    result.addAll({'category': category});
    result.addAll({'desc': desc});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userId: map['userId'] ?? '',
      orderId: map['orderId'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      userName: map['userName'] ?? '',
      userAddress: map['userAddress'] ?? '',
      userPhone: map['userPhone'] ?? '',
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate']),
      status: map['status'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      category: map['category'] ?? '',
      desc: map['desc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(userId: $userId, orderId: $orderId, name: $name, price: $price, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, orderDate: $orderDate, status: $status, quantity: $quantity, category: $category, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.userId == userId &&
        other.orderId == orderId &&
        other.name == name &&
        other.price == price &&
        other.userName == userName &&
        other.userAddress == userAddress &&
        other.userPhone == userPhone &&
        other.orderDate == orderDate &&
        other.status == status &&
        other.quantity == quantity &&
        other.category == category &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        orderId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        userName.hashCode ^
        userAddress.hashCode ^
        userPhone.hashCode ^
        orderDate.hashCode ^
        status.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        desc.hashCode;
  }
}
