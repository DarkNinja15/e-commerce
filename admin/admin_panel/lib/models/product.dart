import 'dart:convert';

class Product {
  final String id;
  final String photoUrl;
  final String name;
  final String desc;
  final double price;
  Product({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.desc,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? photoUrl,
    String? name,
    String? desc,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'name': name});
    result.addAll({'desc': desc});
    result.addAll({'price': price});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, photoUrl: $photoUrl, name: $name, desc: $desc, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.photoUrl == photoUrl &&
        other.name == name &&
        other.desc == desc &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photoUrl.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode;
  }
}
