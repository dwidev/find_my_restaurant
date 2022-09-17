import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../providers/catalog_provider.dart';
import '../providers/detail_resto_provider.dart';
import '../widgets/catalog_restaurant_title_widget.dart';
import '../widgets/item_tile_loading_widget.dart';
import '../widgets/item_tile_widget.dart';
import 'detail_restaurant_page.dart';

class CatalogRestaurantPage extends StatefulWidget {
  const CatalogRestaurantPage({Key? key}) : super(key: key);

  @override
  State<CatalogRestaurantPage> createState() => _CatalogRestaurantPageState();
}

class _CatalogRestaurantPageState extends State<CatalogRestaurantPage> {
  bool isClearSearch = false;
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CatalogProvider>().getCatalogRestaurant();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onClearSearch() {
    searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<CatalogProvider>().onLoading(withNotify: true);
    context.read<CatalogProvider>().getCatalogRestaurant();
    setState(() {
      isClearSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CatalogRestaurantTitleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search disini",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: isClearSearch
                    ? IconButton(
                        onPressed: _onClearSearch,
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isClearSearch = false;
                  });
                } else {
                  setState(() {
                    isClearSearch = true;
                  });
                }
              },
              onSubmitted: (value) {
                context
                    .read<CatalogProvider>()
                    .searchCatalogRestaurant(keyword: value);
              },
            ),
          ),
          Expanded(
            child: Consumer<CatalogProvider>(
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
                final itemCount =
                    value.isLoading ? 10 : value.state.listResto.length;

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
                        context.push(
                          page: DetailRestaurantPage(
                            restoId: restaurantModel.id,
                            heroTag: heroTag,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
