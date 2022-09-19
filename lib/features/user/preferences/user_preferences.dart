import 'dart:convert';

import '../../../core/local_preference/base_local_preference.dart';
import '../data/user_model.dart';

abstract class UserPreference {
  Future<void> setUser({required UserModel userModel});
  Future<UserModel> getUser();
}

class UserPreferenceImpl extends BaseLocalPreferenceImpl
    implements UserPreference {
  static const keyUserData = "user_data";

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
}
