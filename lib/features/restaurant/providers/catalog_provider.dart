import '../../../core/core.dart';
import '../data/model/restaurant_model.dart';
import '../services/restaurant_service.dart';

class CatalogProvider extends BaseProvider<_CatalogState> {
  final RestaurantService restaurantService;

  CatalogProvider({required this.restaurantService}) : super(_CatalogState());

  /// function for get list restaurant
  Future<void> getCatalogRestaurant() async {
    onLoading();
    final request = await restaurantService.getListResto();

    request.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(listResto: data));
        onSuccess();
      },
      err: (err) {
        onError(failure: err);
      },
    );
  }

  /// function for get list restaurant
  Future<void> searchCatalogRestaurant({required String keyword}) async {
    onLoading();
    final request = await restaurantService.searchResto(keyword);

    request.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(listResto: data));
        onSuccess();
      },
      err: (err) {
        onError(failure: err);
      },
    );
  }
}

class _CatalogState extends BaseState {
  final List<RestaurantModel> listResto;

  _CatalogState({
    this.listResto = const [],
  });

  _CatalogState copyWith({
    List<RestaurantModel>? listResto,
  }) {
    return _CatalogState(
      listResto: listResto ?? this.listResto,
    );
  }
}
