import '../../../core/core.dart';

class CatalogRestaurantTitleWidget extends StatelessWidget {
  const CatalogRestaurantTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: context.textTheme.headline6,
              children: [
                const TextSpan(text: "Welcome to "),
                TextSpan(
                  text: "Find My Restaurant",
                  style: context.textTheme.headline5?.copyWith(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "this recommendation restaurant for you.",
            style: context.textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
