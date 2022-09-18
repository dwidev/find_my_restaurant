import 'dart:convert';
import 'dart:math';

import 'customer_review_model.dart';
import 'menus_model.dart';

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.distance,
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
  final String distance;
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
    final distance = Random().nextInt(10) + 3; // dummy distance by random int

    // set famous tag when rating greater than 4
    final isFamous = (map['rating']?.toDouble() ?? 0.0) > 4;

    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      distance: "$distance km",
      rating: map['rating']?.toDouble() ?? 0.0,
      isFamous: isFamous,
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
