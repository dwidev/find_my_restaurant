import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import 'features/restaurant/providers/catalog_provider.dart';
import 'features/restaurant/providers/detail_resto_provider.dart';
import 'features/restaurant/services/restaurant_service.dart';
import 'features/splash/page/splash_page.dart';

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
      ],
      builder: (context, child) {
        return MaterialApp(
          title: "Find My Restaurant",
          theme: baseTheme,
          home: const SplashPage(),
        );
      },
    );
  }
}
