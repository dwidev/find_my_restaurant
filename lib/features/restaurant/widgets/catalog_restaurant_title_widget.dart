import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';

class CatalogRestaurantTitleWidget extends StatelessWidget {
  const CatalogRestaurantTitleWidget({
    Key? key,
  }) : super(key: key);

  void _goToProfile() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (true) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircileIconWidget(
                  onPressed: _goToProfile,
                  isShadow: false,
                  iconWithProperty: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                  ),
                ),
                InkWell(
                  onTap: _goToProfile,
                  child: Text(
                    "Hiii Fahmi",
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          },
          const SizedBox(height: 20),
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
