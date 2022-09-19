import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../user/page/user_setting_page.dart';
import '../../user/providers/user_provider.dart';
import '../pages/detail_restaurant_page.dart';
import '../providers/detail_resto_provider.dart';
import 'item_tile_loading_widget.dart';
import 'item_tile_widget.dart';

class CatalogRestaurantTitleWidget extends StatelessWidget {
  const CatalogRestaurantTitleWidget({
    Key? key,
  }) : super(key: key);

  void _goToProfile(BuildContext context) {
    context.push(page: const UserProfilePage());
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
                    GestureDetector(
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
