import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/core.dart';
import '../data/model/restaurant_model.dart';
import '../widgets/catalog_restaurant_title_widget.dart';
import '../widgets/item_tile_widget.dart';
import 'detail_restaurant_page.dart';

class CatalogRestaurantPage extends StatefulWidget {
  const CatalogRestaurantPage({Key? key}) : super(key: key);

  @override
  State<CatalogRestaurantPage> createState() => _CatalogRestaurantPageState();
}

class _CatalogRestaurantPageState extends State<CatalogRestaurantPage> {
  var restaurans = <RestaurantModel>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await rootBundle.loadString('assets/local_restaurant.json');
      final list = (jsonDecode(data)["restaurants"] as List)
          .map((e) => RestaurantModel.fromMap(e))
          .toList();

      setState(() {
        restaurans = list;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    print("ON DISPOSE");
    super.dispose();
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
          Expanded(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: restaurans.length,
            itemBuilder: (context, index) {
              final restaurantModel = restaurans[index];
              return RestaurantTileWidget(
                restaurantModel: restaurantModel,
                onPressed: (String id) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRestaurantPage(
                        heroTag: "list-tile-${restaurantModel.id}",
                        restaurantModel: restaurantModel,
                        listResto: restaurans,
                      ),
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
