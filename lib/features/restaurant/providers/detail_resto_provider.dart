import '../../../core/core.dart';
import '../../../core/services/failure.dart';
import '../../../core/services/result.dart';
import '../data/model/customer_review_model.dart';
import '../data/model/menu_item_model.dart';
import '../data/model/menus_model.dart';
import '../data/model/restaurant_model.dart';
import '../services/restaurant_service.dart';

class DetailRestoProvider extends BaseProvider<_DetailRestoState> {
  final RestaurantService restaurantService;

  DetailRestoProvider({required this.restaurantService})
      : super(_DetailRestoState());

  RestaurantModel? get resto => state.restaurantModel;
  List<MenuItemModel> get foods => state.menuModel?.foods ?? [];
  List<MenuItemModel> get drinks => state.menuModel?.drinks ?? [];
  List<CustomerReviewModel> get listCustomerReview =>
      state.restaurantModel?.customerReviews ?? [];
  List<RestaurantModel> get othersResto => state.othersResto;

  /// function for get list restaurant
  Future<void> getDetailResto(String restoId, {bool withNotify = false}) async {
    onLoading(withNotify: withNotify);

    // delay for hero animation
    await Future.delayed(const Duration(seconds: 1));

    final request = await Future.wait([
      restaurantService.getDetailResto(restoId),
      restaurantService.getListResto(),
    ]);

    final requestDetail = request[0] as Result<RestaurantModel, Failure>;
    final requestOthersResto =
        request[1] as Result<List<RestaurantModel>, Failure>;

    requestDetail.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(
          restaurantModel: data,
          menuModel: data.menus,
        ));
        onSuccess();
      },
      err: (err) {
        onError(failure: err);
      },
    );
    requestOthersResto.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(
          othersResto: data.where((resto) => resto.id != restoId).toList(),
        ));
        onSuccess();
      },
      err: (err) {
        onError(failure: err);
      },
    );
  }
}

class _DetailRestoState extends BaseState {
  final List<RestaurantModel> othersResto;
  final RestaurantModel? restaurantModel;
  final MenuModel? menuModel;

  _DetailRestoState({
    this.othersResto = const [],
    this.restaurantModel,
    this.menuModel,
  });

  _DetailRestoState copyWith({
    List<RestaurantModel>? othersResto,
    RestaurantModel? restaurantModel,
    MenuModel? menuModel,
  }) {
    return _DetailRestoState(
      othersResto: othersResto ?? this.othersResto,
      restaurantModel: restaurantModel ?? this.restaurantModel,
      menuModel: menuModel ?? this.menuModel,
    );
  }
}
