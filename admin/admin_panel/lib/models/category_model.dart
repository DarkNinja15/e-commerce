import 'dart:convert';

class Category {
  final String catUid;
  final String thumbnailPicUrl;
  final String name;
  final String userName;
  final String userUid;
  Category({
    required this.catUid,
    required this.thumbnailPicUrl,
    required this.name,
    required this.userName,
    required this.userUid,
  });

  Category copyWith({
    String? catUid,
    String? thumbnailPicUrl,
    String? name,
    String? userName,
    String? userUid,
  }) {
    return Category(
      catUid: catUid ?? this.catUid,
      thumbnailPicUrl: thumbnailPicUrl ?? this.thumbnailPicUrl,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      userUid: userUid ?? this.userUid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'catUid': catUid});
    result.addAll({'thumbnailPicUrl': thumbnailPicUrl});
    result.addAll({'name': name});
    result.addAll({'userName': userName});
    result.addAll({'userUid': userUid});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      catUid: map['catUid'] ?? '',
      thumbnailPicUrl: map['thumbnailPicUrl'] ?? '',
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      userUid: map['userUid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(catUid: $catUid, thumbnailPicUrl: $thumbnailPicUrl, name: $name, userName: $userName, userUid: $userUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.catUid == catUid &&
        other.thumbnailPicUrl == thumbnailPicUrl &&
        other.name == name &&
        other.userName == userName &&
        other.userUid == userUid;
  }

  @override
  int get hashCode {
    return catUid.hashCode ^
        thumbnailPicUrl.hashCode ^
        name.hashCode ^
        userName.hashCode ^
        userUid.hashCode;
  }
}
