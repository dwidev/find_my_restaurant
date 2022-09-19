import 'dart:convert';

import '../../../core/local_preference/base_local_preference.dart';
import '../../restaurant/data/model/restaurant_model.dart';
import '../data/user_model.dart';

abstract class UserPreference {
  Future<void> setUser({required UserModel userModel});
  Future<UserModel> getUser();
  Future<bool> checkRestoFavorite({
    required String restoId,
  });
  Future<void> favoriteResto({
    required RestaurantModel restaurantModel,
  });
  Future<List<RestaurantModel>> getFavoriteResto();
}

class UserPreferenceImpl extends BaseLocalPreferenceImpl
    implements UserPreference {
  static const keyUserData = "user_data";
  static const keyFavResto = "fav_resto";

  @override
  Future<void> setUser({required UserModel userModel}) async {
    final pref = await preference;

    final data = userModel.toJson();
    await pref.setString(keyUserData, data);
  }

  @override
  Future<UserModel> getUser() async {
    final pref = await preference;
    final stringData = pref.getString(keyUserData) ?? '';
    return UserModel.fromJson(stringData);
  }

  @override
  Future<void> favoriteResto({
    required RestaurantModel restaurantModel,
  }) async {
    final pref = await preference;
    final listResto = await getFavoriteResto();
    final available = await checkRestoFavorite(restoId: restaurantModel.id);
    if (available) {
      listResto.removeWhere((element) => element.id == restaurantModel.id);
    } else {
      listResto.add(restaurantModel);
    }

    final data = listResto.map((e) => e.toJson()).toList().toString();
    await pref.setString(keyFavResto, data);
  }

  @override
  Future<List<RestaurantModel>> getFavoriteResto() async {
    final pref = await preference;
    final stringData = pref.getString(keyFavResto) ?? '';

    List<RestaurantModel> listResto = [];

    if (stringData.isNotEmpty) {
      listResto = (json.decode(stringData) as List)
          .map((e) => RestaurantModel.fromMap(e))
          .toList();
    }

    return listResto;
  }

  @override
  Future<bool> checkRestoFavorite({required String restoId}) async {
    final listRestoFav = await getFavoriteResto();
    final check =
        listRestoFav.where((element) => element.id == restoId).toList();
    return check.isNotEmpty;
  }
}
