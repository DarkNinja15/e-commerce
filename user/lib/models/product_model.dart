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
  final String sellerUid;
  final String category;
  final bool isPromoted;
  Product({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.desc,
    required this.price,
    required this.quantity,
    this.discount = 0,
    this.discountProductLimit = 0,
    required this.sellerUid,
    required this.category,
    this.isPromoted = false,
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
    String? sellerUid,
    String? category,
    bool? isPromoted,
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
      sellerUid: sellerUid ?? this.sellerUid,
      category: category ?? this.category,
      isPromoted: isPromoted ?? this.isPromoted,
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
    result.addAll({'sellerUid': sellerUid});
    result.addAll({'category': category});
    result.addAll({'isPromoted': isPromoted});

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
      sellerUid: map['sellerUid'] ?? '',
      category: map['category'] ?? '',
      isPromoted: map['isPromoted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, photoUrl: $photoUrl, name: $name, desc: $desc, price: $price, quantity: $quantity, discount: $discount, discountProductLimit: $discountProductLimit, sellerUid: $sellerUid, category: $category, isPromoted: $isPromoted)';
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
        other.discountProductLimit == discountProductLimit &&
        other.sellerUid == sellerUid &&
        other.category == category &&
        other.isPromoted == isPromoted;
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
        discountProductLimit.hashCode ^
        sellerUid.hashCode ^
        category.hashCode ^
        isPromoted.hashCode;
  }
}
