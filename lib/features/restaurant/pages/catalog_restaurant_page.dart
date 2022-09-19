import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../user/providers/user_provider.dart';
import '../../user/widget/no_session_dialog.dart';
import '../providers/catalog_provider.dart';
import '../providers/detail_resto_provider.dart';
import '../view/catalog_restaurant_view.dart';
import '../view/favorite_restaurant_view.dart';
import '../widgets/catalog_restaurant_title_widget.dart';
import '../widgets/item_tile_loading_widget.dart';
import '../widgets/item_tile_widget.dart';
import 'detail_restaurant_page.dart';

class CatalogRestaurantPage extends StatefulWidget {
  const CatalogRestaurantPage({Key? key}) : super(key: key);

  @override
  State<CatalogRestaurantPage> createState() => _CatalogRestaurantPageState();
}

class _CatalogRestaurantPageState extends State<CatalogRestaurantPage>
    with SingleTickerProviderStateMixin {
  bool isClearSearch = false;
  late TabController tabController;
  late TextEditingController searchController;
  int _currentTab = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this)
      ..addListener(_onChangeTab);
    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<UserProvider>().getFavoriteRestaurant();
      context.read<CatalogProvider>().getCatalogRestaurant();
      _checkSession();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(_onChangeTab);
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _onChangeTab() {
    setState(() {
      _currentTab = tabController.index;
    });
    if (_currentTab == 1) {
      context.read<UserProvider>().getFavoriteRestaurant();
    }
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

  void _checkSession() {
    context.read<UserProvider>().checkSession().then((isSession) {
      if (isSession == false) {
        showNoSessionDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favCount = context.select<UserProvider, int>(
      (prov) => prov.state.listFavorite.length,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: context.mediaQuery.viewPadding.top + 10),
        child: Column(
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
                  if (value.isNotEmpty) {
                    context
                        .read<CatalogProvider>()
                        .searchCatalogRestaurant(keyword: value);
                  }
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        "Explore",
                        style: context.textTheme.bodyText1?.copyWith(
                          color: _currentTab == 0
                              ? primaryColor
                              : darkColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Favorite ($favCount)",
                        style: context.textTheme.bodyText1?.copyWith(
                          color: _currentTab == 1
                              ? primaryColor
                              : darkColor.withOpacity(0.5),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CatalogRestoView(),
                  FavoriteRestoView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
