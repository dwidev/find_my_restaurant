import 'core/core.dart';
import 'features/splash/page/splash_page.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Find My Restaurant",
      theme: baseTheme,
      home: const SplashPage(),
    );
  }
}
