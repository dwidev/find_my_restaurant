import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    SharedPreferences.getInstance().then((pref) {
      final isDark = pref.getBool(themeKey) ?? false;
      if (isDark) {
        setDarkTheme();
      } else {
        setLightTheme();
      }
    });
  }
  static const themeKey = "theme";

  ThemeData _currentTheme = lightTheme;
  ThemeMode _themeMode = ThemeMode.light;

  bool get isDark => _themeMode == ThemeMode.dark;
  ThemeData get currentTheme => _currentTheme;
  ThemeMode get themeMode => _themeMode;

  set setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  Future<void> setDarkTheme() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(themeKey, true);
    _themeMode = ThemeMode.dark;
    setTheme = darkTheme;
  }

  Future<void> setLightTheme() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(themeKey, false);
    _themeMode = ThemeMode.light;
    setTheme = lightTheme;
  }
}
