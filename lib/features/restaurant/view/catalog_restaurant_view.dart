import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../pages/detail_restaurant_page.dart';
import '../providers/catalog_provider.dart';
import '../providers/detail_resto_provider.dart';
import '../widgets/item_tile_loading_widget.dart';
import '../widgets/item_tile_widget.dart';

class CatalogRestoView extends StatelessWidget {
  const CatalogRestoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogProvider>(
      builder: (context, value, child) {
        if (value.isError) {
          return RestoErrorWidget(
            failure: value.errorFailure,
            onRetry: () {
              value.getCatalogRestaurant();
            },
          );
        }

        if (value.isSuccess && value.state.listResto.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  searchIcon,
                  width: 100,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: context.widthSize / 1.5,
                  child: Text(
                    "Upss.. tidak ada data yang ditemukan",
                    style: context.textTheme.caption?.copyWith(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }
        final itemCount = value.isLoading ? 10 : value.state.listResto.length;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (value.isLoading) {
              return RestaurantTileLoadingWidget(
                isLoading: value.isLoading,
              );
            }

            final restaurantModel = value.state.listResto[index];
            final heroTag = "list-tile-${restaurantModel.id}";

            return RestaurantTileWidget(
              heroTag: heroTag,
              restaurantModel: restaurantModel,
              onPressed: (String id) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<DetailRestoProvider>().getDetailResto(id);
                final args = DetailRestaurantPageArgs(
                  restoId: restaurantModel.id,
                  heroTag: heroTag,
                  image: "$largeResolution${restaurantModel.pictureId}",
                  distance: restaurantModel.distance,
                );

                Navigation.intentWithData(
                  DetailRestaurantPage.routeName,
                  args,
                );
              },
            );
          },
        );
      },
    );
  }
}
