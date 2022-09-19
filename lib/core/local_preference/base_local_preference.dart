import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalPreferenceImpl {
  Future<SharedPreferences> get preference async {
    return await SharedPreferences.getInstance();
  }
}
