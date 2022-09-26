import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/core.dart';
import '../data/model/restaurant_model.dart';

class RestaurantTileWidget extends StatelessWidget {
  const RestaurantTileWidget({
    Key? key,
    required this.heroTag,
    required this.restaurantModel,
    required this.onPressed,
  }) : super(key: key);

  final String heroTag;
  final RestaurantModel restaurantModel;
  final Function(String restroId) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(restaurantModel.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        width: context.widthSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        "$largeResolution${restaurantModel.pictureId}"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurantModel.name,
                          style: context.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      if (restaurantModel.isFamous)
                        const RestaurantBadgeWidget(
                          text: "famous",
                        )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        "${restaurantModel.city}, ${restaurantModel.distance}",
                        style: context.textTheme.subtitle1?.copyWith(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.star),
                      Text(
                        "${restaurantModel.rating}",
                        style: context.textTheme.subtitle1?.copyWith(),
                      ),
                    ],
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
