import 'dart:convert';

class MenuItemModel {
  MenuItemModel({
    required this.name,
    required this.price,
  });

  final String name;
  final String price;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItemModel.fromJson(String source) =>
      MenuItemModel.fromMap(json.decode(source));
}
