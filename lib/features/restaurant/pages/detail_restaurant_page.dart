import 'dart:math';

import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/services/failure.dart';
import '../data/model/customer_review_model.dart';
import '../data/model/menu_item_model.dart';
import '../data/model/restaurant_model.dart';
import '../providers/detail_resto_provider.dart';
import '../widgets/menu_item_widget.dart';
import '../widgets/others_restaurant_tile_widget.dart';
import 'customer_review_page.dart';

class DetailRestaurantPage extends StatelessWidget {
  const DetailRestaurantPage({
    Key? key,
    required this.restoId,
    required this.heroTag,
  }) : super(key: key);

  final String restoId;
  final String heroTag;

  List<Widget> descLoadingWidget(BuildContext context) {
    return [
      ...("a," * 10).split(",").toList().map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingEffectAnimationWidget(
                    isLoading: true,
                    width: Random().nextInt(context.widthSize.toInt()) +
                        100.toDouble(),
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
      const SizedBox(height: 20),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<DetailRestoProvider, bool>(
      (value) => value.isLoading,
    );
    final isSuccess = context.select<DetailRestoProvider, bool>(
      (value) => value.isSuccess,
    );
    final failure = context.select<DetailRestoProvider, Failure?>(
      (value) => value.errorFailure,
    );
    final resto = context.select<DetailRestoProvider, RestaurantModel?>(
      (value) => value.resto,
    );
    final foods = context.select<DetailRestoProvider, List<MenuItemModel>>(
      (value) => value.foods,
    );
    final drinks = context.select<DetailRestoProvider, List<MenuItemModel>>(
      (value) => value.drinks,
    );
    final reviews =
        context.select<DetailRestoProvider, List<CustomerReviewModel>>(
      (value) => value.listCustomerReview,
    );
    final othersResto =
        context.select<DetailRestoProvider, List<RestaurantModel>>(
      (value) => value.othersResto,
    );

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
                  if (isLoading) ...{
                    LoadingEffectAnimationWidget(
                      isLoading: true,
                      width: context.widthSize,
                      height: context.heightSize / 3,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    )
                  } else if (isSuccess) ...{
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
                          image: NetworkImage(
                            "$largeResolution${resto?.pictureId}",
                          ),
                        ),
                      ),
                    )
                  } else ...{
                    Container(
                      width: context.widthSize,
                      height: context.heightSize / 3,
                      decoration: const BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  },
                  const BackIconWidget(),
                ],
              ),
            ),
            Container(
              width: context.widthSize,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoading) ...{
                    const SizedBox(height: 5),
                    const LoadingEffectAnimationWidget(
                      isLoading: true,
                      width: 200,
                      height: 20,
                    ),
                    const SizedBox(height: 6),
                    const LoadingEffectAnimationWidget(
                      isLoading: true,
                      width: 150,
                      height: 15,
                    ),
                  } else if (isSuccess) ...{
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: context.textTheme.headline5,
                                  children: [
                                    TextSpan(text: resto?.name ?? "-"),
                                    if (resto?.isFamous ?? true)
                                      const WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: RestaurantBadgeWidget(
                                            text: "famous",
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on),
                                  Text(
                                    "${resto?.city}, 15km",
                                    style: context.textTheme.subtitle1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (resto?.customerReviews.isNotEmpty == true)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ReviewWidget(
                                  rating: resto?.rating ?? 0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push(
                                      page:
                                          CustomerReviewPage(reviews: reviews),
                                    );
                                  },
                                  child: Text(
                                    "Lihat reviews",
                                    style: context.textTheme.caption,
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  }
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  if (isLoading) ...{
                    ...descLoadingWidget(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: LoadingEffectAnimationWidget(
                            isLoading: true,
                            width: 120,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 21),
                    Row(
                        children: ["1", "2", "3"]
                            .map((e) => Padding(
                                  padding:
                                      EdgeInsets.only(left: e == "1" ? 20 : 10),
                                  child: const LoadingEffectAnimationWidget(
                                    isLoading: true,
                                    width: MenuItemWidget.width,
                                    height: MenuItemWidget.height,
                                  ),
                                ))
                            .toList()),
                  } else if (isSuccess) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        resto?.description ?? "-",
                        style: context.textTheme.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (foods.isNotEmpty || drinks.isNotEmpty) ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Menu",
                          style: context.textTheme.headline6,
                        ),
                      ),
                    },
                    const SizedBox(height: 21),
                    if (foods.isNotEmpty) ...{
                      SizedBox(
                        height: MenuItemWidget.height,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            final menuItemModel = foods[index];
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
                    },
                    if (foods.isNotEmpty) ...{
                      const SizedBox(height: 22),
                      SizedBox(
                        height: MenuItemWidget.height,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: drinks.length,
                          itemBuilder: (context, index) {
                            final menuItemModel = drinks[index];
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
                    },
                    const SizedBox(height: 21.5),
                    if (othersResto.isNotEmpty)
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
                      itemCount: othersResto.length,
                      itemBuilder: (context, index) {
                        final othersRestaurant = othersResto[index];
                        return OthersRestaurantTileWidget(
                          restaurantModel: othersRestaurant,
                          onPressed: () {
                            context
                                .read<DetailRestoProvider>()
                                .getDetailResto(othersRestaurant.id);

                            context.pushReplacement(
                              page: DetailRestaurantPage(
                                restoId: restoId,
                                heroTag: "others-detail-${othersRestaurant.id}",
                              ),
                            );
                          },
                        );
                      },
                    ),
                  } else ...{
                    RestoErrorWidget(
                      failure: failure,
                      onRetry: () {
                        context
                            .read<DetailRestoProvider>()
                            .getDetailResto(restoId, withNotify: true);
                      },
                    ),
                  },
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
