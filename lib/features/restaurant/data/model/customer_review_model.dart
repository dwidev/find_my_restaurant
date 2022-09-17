import 'dart:convert';

class CustomerReviewModel {
  final String name;
  final String review;
  final String date;

  CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }

  factory CustomerReviewModel.fromMap(Map<String, dynamic> map) {
    return CustomerReviewModel(
      name: map['name'] ?? '',
      review: map['review'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerReviewModel.fromJson(String source) =>
      CustomerReviewModel.fromMap(json.decode(source));
}
