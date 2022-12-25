import 'dart:convert';

class Product {
  final String id;
  final String photoUrl;
  final String name;
  final String desc;
  final double price;
  final int quantity;
  final double discount;
  final int discountProductLimit;
  Product({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.desc,
    required this.price,
    required this.quantity,
    this.discount = 0,
    this.discountProductLimit = 0,
  });

  Product copyWith({
    String? id,
    String? photoUrl,
    String? name,
    String? desc,
    double? price,
    int? quantity,
    double? discount,
    int? discountProductLimit,
  }) {
    return Product(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      discountProductLimit: discountProductLimit ?? this.discountProductLimit,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'name': name});
    result.addAll({'desc': desc});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'discount': discount});
    result.addAll({'discountProductLimit': discountProductLimit});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      discount: map['discount']?.toDouble() ?? 0.0,
      discountProductLimit: map['discountProductLimit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, photoUrl: $photoUrl, name: $name, desc: $desc, price: $price, quantity: $quantity, discount: $discount, discountProductLimit: $discountProductLimit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.photoUrl == photoUrl &&
        other.name == name &&
        other.desc == desc &&
        other.price == price &&
        other.quantity == quantity &&
        other.discount == discount &&
        other.discountProductLimit == discountProductLimit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photoUrl.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        discount.hashCode ^
        discountProductLimit.hashCode;
  }
}