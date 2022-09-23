import 'dart:math';

import '../../../core/services/base_service.dart';
import '../../../core/services/failure.dart';
import '../../../core/services/result.dart';
import '../../user/preferences/user_preferences.dart';
import '../data/model/customer_review_model.dart';
import '../data/model/restaurant_model.dart';

abstract class RestaurantService {
  Future<RestaurantModel?> getRecomendationRestaurant();
  Future<Result<List<RestaurantModel>, Failure>> getListResto();
  Future<Result<RestaurantModel, Failure>> getDetailResto(
    String restoID,
  );
  Future<Result<List<RestaurantModel>, Failure>> searchResto(
    String keyword,
  );
  Future<Result<List<CustomerReviewModel>, Failure>> addReviewByUser({
    required String name,
    required String restoId,
    required String review,
  });
}

/// class for handle call api restaurant
class RestaurantServiceImpl extends BaseService implements RestaurantService {
  final UserPreference userPreference;

  RestaurantServiceImpl({
    required super.client,
    required this.userPreference,
  });

  /// function for get list restaurant from api
  @override
  Future<Result<List<RestaurantModel>, Failure>> getListResto() async {
    return guards(process: () async {
      final response = await client.get("/list");
      final listResto = (response.data["restaurants"] as List);
      final list = listResto.map((e) => RestaurantModel.fromMap(e)).toList();
      return Ok(list);
    });
  }

  /// function for get list restaurant from api
  @override
  Future<Result<RestaurantModel, Failure>> getDetailResto(
    String restoID,
  ) async {
    return guards(process: () async {
      final response = await client.get("/detail/$restoID");
      final isFav = await userPreference.checkRestoFavorite(restoId: restoID);
      final resto = RestaurantModel.fromMap(response.data["restaurant"]);
      final newResto = resto.copyWith(isFavorite: isFav);
      return Ok(newResto);
    });
  }

  /// function for get list restaurant from api
  @override
  Future<Result<List<RestaurantModel>, Failure>> searchResto(
    String keyword,
  ) async {
    return guards(process: () async {
      final params = {"q": keyword};
      final response = await client.get("/search", queryParameters: params);
      final listResto = (response.data["restaurants"] as List);
      final list = listResto.map((e) => RestaurantModel.fromMap(e)).toList();
      return Ok(list);
    });
  }

  /// function for get list restaurant from api
  @override
  Future<Result<List<CustomerReviewModel>, Failure>> addReviewByUser({
    required String name,
    required String restoId,
    required String review,
  }) async {
    return guards(process: () async {
      final data = {
        "id": restoId,
        "name": name,
        "review": review,
      };
      final response = await client.post("/review", data: data);
      final listReview = (response.data["customerReviews"] as List);
      final list =
          listReview.map((e) => CustomerReviewModel.fromMap(e)).toList();
      return Ok(list);
    });
  }

  /// function for get random restaurant
  @override
  Future<RestaurantModel?> getRecomendationRestaurant() async {
    final request = await getListResto();

    return request.capture(
      ok: (data) {
        final randomIndex = Random().nextInt(data.length);
        return data[randomIndex];
      },
      err: (err) {
        return null;
      },
    );
  }
}
