import '../../../core/services/base_service.dart';
import '../../../core/services/failure.dart';
import '../../../core/services/result.dart';
import '../../restaurant/data/model/restaurant_model.dart';
import '../data/user_model.dart';
import '../preferences/user_preferences.dart';

class UserService with Guards {
  final UserPreference userPreference;

  UserService({
    required this.userPreference,
  });

  Future<Result<UserModel, Failure>> setUser({
    required UserModel userModel,
  }) async {
    return guards(
      process: () async {
        await userPreference.setUser(userModel: userModel);
        return Ok(userModel);
      },
    );
  }

  Future<Result<UserModel, Failure>> getUser() async {
    return guards(
      process: () async {
        final userModel = await userPreference.getUser();
        return Ok(userModel);
      },
    );
  }

  Future<Result<bool, Failure>> favoriteResto({
    required RestaurantModel restaurantModel,
  }) async {
    return guards(
      process: () async {
        await userPreference.favoriteResto(restaurantModel: restaurantModel);
        return Ok(true);
      },
    );
  }
}
