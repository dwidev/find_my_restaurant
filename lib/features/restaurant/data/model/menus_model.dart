import 'dart:convert';

import 'menu_item_model.dart';

class MenuModel {
  MenuModel({
    required this.foods,
    required this.drinks,
  });

  final List<MenuItemModel> foods;
  final List<MenuItemModel> drinks;

  Map<String, dynamic> toMap() {
    return {
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      foods: List<MenuItemModel>.from(
          map['foods']?.map((x) => MenuItemModel.fromMap(x))),
      drinks: List<MenuItemModel>.from(
          map['drinks']?.map((x) => MenuItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source));
}
