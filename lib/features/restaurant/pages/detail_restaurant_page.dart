import 'package:flutter/cupertino.dart';

import '../../../core/core.dart';
import '../data/model/restaurant_model.dart';
import '../widgets/menu_item_widget.dart';
import '../widgets/others_restaurant_tile_widget.dart';

class DetailRestaurantPage extends StatelessWidget {
  const DetailRestaurantPage({
    Key? key,
    required this.heroTag,
    required this.restaurantModel,
    required this.listResto,
  }) : super(key: key);

  final String heroTag;
  final RestaurantModel restaurantModel;
  final List<RestaurantModel> listResto;

  @override
  Widget build(BuildContext context) {
    final sugestionResto =
        listResto.where((resto) => resto.id != restaurantModel.id).toList();

    return Scaffold(
      body: SizedBox(
        width: context.widthSize,
        height: context.heightSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: Stack(
                children: [
                  Container(
                    width: context.widthSize,
                    height: context.heightSize / 3,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(restaurantModel.pictureId),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: context.mediaQuery.padding.top + 15,
                        left: 15,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: darkColor.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.back,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: context.widthSize,
              // height: context.heightSize,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: context.textTheme.headline5,
                      children: [
                        TextSpan(text: restaurantModel.name),
                        if (restaurantModel.isMostLiked)
                          const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: RestaurantBadgeWidget(text: "most liked"),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on),
                            Expanded(
                              child: Text(
                                "${restaurantModel.city}, 15km",
                                style: context.textTheme.subtitle1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      restaurantModel.description,
                      style: context.textTheme.subtitle1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Menu",
                      style: context.textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MenuItemWidget.height,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantModel.menus.foods.length,
                      itemBuilder: (context, index) {
                        final menuItemModel =
                            restaurantModel.menus.foods[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: MenuItemWidget(
                            menuItemModel: menuItemModel,
                            backgroundImage:
                                "https://cdn-cas.orami.co.id/parenting/images/makanan-tradisional-.width-800.jpegquality-80.jpg",
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MenuItemWidget.height,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantModel.menus.drinks.length,
                      itemBuilder: (context, index) {
                        final menuItemModel =
                            restaurantModel.menus.drinks[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: MenuItemWidget(
                            menuItemModel: menuItemModel,
                            backgroundImage:
                                "https://gobiz.co.id/pusat-pengetahuan/wp-content/uploads/2022/05/Menu-Minuman-Kekinian-Thai-Tea-.jpg",
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (sugestionResto.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Others restaurant",
                        style: context.textTheme.headline6,
                      ),
                    ),
                  GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: sugestionResto.length,
                    itemBuilder: (context, index) {
                      final othersRestaurant = sugestionResto[index];
                      return OthersRestaurantTileWidget(
                        restaurantModel: othersRestaurant,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRestaurantPage(
                                heroTag: "others-detail-${othersRestaurant.id}",
                                restaurantModel: othersRestaurant,
                                listResto: listResto,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
