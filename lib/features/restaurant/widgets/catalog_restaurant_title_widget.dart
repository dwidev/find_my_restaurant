import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';
import '../../splash/page/splash_page.dart';
import '../../user/providers/user_provider.dart';

class CatalogRestaurantTitleWidget extends StatelessWidget {
  const CatalogRestaurantTitleWidget({
    Key? key,
  }) : super(key: key);

  void _goToProfile(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      value.clear();
      context.pushReplacement(page: const SplashPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<UserProvider>(
            builder: (context, value, child) {
              if (value.isSession) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircileIconWidget(
                      onPressed: () => _goToProfile(context),
                      isShadow: false,
                      iconWithProperty: const Icon(
                        CupertinoIcons.profile_circled,
                        size: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () => _goToProfile(context),
                      child: Text(
                        "Hiii ${value.state.userModel?.name}",
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  ],
                );
              }

              return const Offstage();
            },
          ),
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
