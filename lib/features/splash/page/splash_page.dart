import '../../../core/core.dart';
import '../../restaurant/pages/catalog_restaurant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CatalogRestaurantPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/app_icon.png", height: 50),
            const SizedBox(height: 10),
            Text(
              "Find My Restaurant",
              style: context.textTheme.headline5?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "find and recommend resturants for you.",
              style: context.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
