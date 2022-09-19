import '../../../core/services/base_service.dart';
import '../../../core/services/failure.dart';
import '../../../core/services/result.dart';
import '../../user/preferences/user_preferences.dart';
import '../data/model/customer_review_model.dart';
import '../data/model/restaurant_model.dart';

/// class for handle call api restaurant
class RestaurantService extends BaseService {
  final UserPreference userPreference;

  RestaurantService({
    required super.client,
    required this.userPreference,
  });

  /// function for get list restaurant from api
  Future<Result<List<RestaurantModel>, Failure>> getListResto() async {
    return guards(process: () async {
      final response = await get(path: "/list");
      final listResto = (response.data["restaurants"] as List);
      final list = listResto.map((e) => RestaurantModel.fromMap(e)).toList();
      return Ok(list);
    });
  }

  /// function for get list restaurant from api
  Future<Result<RestaurantModel, Failure>> getDetailResto(
    String restoID,
  ) async {
    return guards(process: () async {
      final response = await get(path: "/detail/$restoID");
      final isFav = await userPreference.checkRestoFavorite(restoId: restoID);
      final resto = RestaurantModel.fromMap(response.data["restaurant"]);
      final newResto = resto.copyWith(isFavorite: isFav);
      return Ok(newResto);
    });
  }

  /// function for get list restaurant from api
  Future<Result<List<RestaurantModel>, Failure>> searchResto(
    String keyword,
  ) async {
    return guards(process: () async {
      final params = {"q": keyword};
      final response = await get(path: "/search", queryParameters: params);
      final listResto = (response.data["restaurants"] as List);
      final list = listResto.map((e) => RestaurantModel.fromMap(e)).toList();
      return Ok(list);
    });
  }

  /// function for get list restaurant from api
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
}
