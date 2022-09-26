import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../user/providers/user_provider.dart';
import '../pages/detail_restaurant_page.dart';
import '../providers/detail_resto_provider.dart';
import '../widgets/item_tile_loading_widget.dart';
import '../widgets/item_tile_widget.dart';

class FavoriteRestoView extends StatelessWidget {
  const FavoriteRestoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        if (value.isError) {
          return SingleChildScrollView(
            child: RestoErrorWidget(
              failure: value.errorFailure,
              onRetry: () {
                value.getFavoriteRestaurant();
              },
            ),
          );
        }

        if (value.isSuccess && value.state.listFavorite.isEmpty) {
          return const RestoErrorWidget(
            description: "Sepertinya belum ada restaurant yang kamu sukai",
          );
        }
        final itemCount =
            value.isLoading ? 10 : value.state.listFavorite.length;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (value.isLoading) {
              return RestaurantTileLoadingWidget(
                isLoading: value.isLoading,
              );
            }

            final restaurantModel = value.state.listFavorite[index];
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
