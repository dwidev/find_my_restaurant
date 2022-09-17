import 'dart:convert';

import 'customer_review_model.dart';
import 'menus_model.dart';

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.isFamous,
    required this.menus,
    required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final bool isFamous;
  final MenuModel? menus;
  final List<CustomerReviewModel> customerReviews;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'isFamous': isFamous,
      'menus': menus?.toMap(),
      'customerReviews': customerReviews.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      isFamous: map['rating']?.toDouble() > 4,
      menus: map['menus'] != null ? MenuModel.fromMap(map['menus']) : null,
      customerReviews: map['customerReviews'] != null
          ? List<CustomerReviewModel>.from((map['customerReviews'] as List)
              .map((x) => CustomerReviewModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source));
}
