import 'package:dio/dio.dart';
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
        ChangeNotifierProvider(create: (context) {
          return CatalogProvider(
            restaurantService: RestaurantService(client: Dio()),
          );
        }),
        ChangeNotifierProvider(create: (context) {
          return DetailRestoProvider(
            restaurantService: RestaurantService(client: Dio()),
          );
        }),
        ChangeNotifierProvider(create: (context) {
          return UserProvider(
            userService: UserService(userPreference: UserPreferenceImpl()),
          );
        }),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: "Find My Restaurant",
          theme: baseTheme,
          themeMode: ThemeMode.dark,
          home: const SplashPage(),
        );
      },
    );
  }
}
