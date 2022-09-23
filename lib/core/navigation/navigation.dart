import 'package:find_my_restaurant/features/user/page/user_setting_page.dart';

import '../../features/restaurant/data/model/restaurant_model.dart';
import '../../features/restaurant/pages/catalog_restaurant_page.dart';
import '../../features/restaurant/pages/customer_review_page.dart';
import '../../features/restaurant/pages/detail_restaurant_page.dart';
import '../../features/splash/page/splash_page.dart';
import '../core.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intentRemoveWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static back() => navigatorKey.currentState?.pop();

  static get routes => {
        SplashPage.routeName: (BuildContext context) {
          return const SplashPage();
        },
        CatalogRestaurantPage.routeName: (BuildContext context) {
          return const CatalogRestaurantPage();
        },
        DetailRestaurantPage.routeName: (BuildContext context) {
          final args = context.argument as DetailRestaurantPageArgs;
          return DetailRestaurantPage(
            args: args,
          );
        },
        CustomerReviewPage.routeName: (BuildContext context) {
          final args = context.argument as RestaurantModel;
          return CustomerReviewPage(
            restaurantModel: args,
          );
        },
        UserSettingsPage.routeName: (BuildContext context) {
          return const UserSettingsPage();
        }
      };
}
