import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'core/theme/theme_provider.dart';
import 'features/restaurant/providers/catalog_provider.dart';
import 'features/restaurant/providers/detail_resto_provider.dart';
import 'features/restaurant/services/restaurant_service.dart';
import 'features/splash/page/splash_page.dart';
import 'features/user/preferences/user_preferences.dart';
import 'features/user/providers/user_notification_provider.dart';
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
            restaurantService: RestaurantServiceImpl(
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
            restaurantService: RestaurantServiceImpl(
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
        ChangeNotifierProvider(
          create: (context) {
            return UserNotificationProvider(
              restaurantService: RestaurantServiceImpl(
                client: Dio(),
                userPreference: UserPreferenceImpl(),
              ),
            );
          },
        ),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, theme, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: "Find My Restaurant",
              darkTheme: darkTheme,
              theme: theme.currentTheme,
              themeMode: ThemeMode.system,
              initialRoute: SplashPage.routeName,
              routes: Navigation.routes,
            );
          },
        );
      },
    );
  }
}
