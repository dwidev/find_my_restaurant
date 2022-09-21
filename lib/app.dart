import 'package:dio/dio.dart';
import 'package:find_my_restaurant/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'features/restaurant/providers/catalog_provider.dart';
import 'features/restaurant/providers/detail_resto_provider.dart';
import 'features/restaurant/services/restaurant_service.dart';
import 'features/splash/page/splash_page.dart';
import 'features/user/preferences/user_preferences.dart';
import 'features/user/providers/user_provider.dart';
import 'features/user/service/user_service.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
        ChangeNotifierProvider(create: (context) {
          return CatalogProvider(
            restaurantService: RestaurantService(
              client: Dio(),
              userPreference: UserPreferenceImpl(),
            ),
          );
        }),
        ChangeNotifierProvider(create: (context) {
          return DetailRestoProvider(
            userService: UserService(
              userPreference: UserPreferenceImpl(),
            ),
            restaurantService: RestaurantService(
              client: Dio(),
              userPreference: UserPreferenceImpl(),
            ),
          );
        }),
        ChangeNotifierProvider(create: (context) {
          return UserProvider(
            userService: UserService(
              userPreference: UserPreferenceImpl(),
            ),
          );
        }),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, theme, child) {
            return MaterialApp(
              title: "Find My Restaurant",
              darkTheme: darkTheme,
              theme: theme.currentTheme,
              themeMode: ThemeMode.system,
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
