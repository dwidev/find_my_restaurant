import 'package:flutter/foundation.dart';

import 'package:find_my_restaurant/features/restaurant/data/model/restaurant_model.dart';

import '../../../core/core.dart';
import '../data/user_model.dart';
import '../service/user_service.dart';

class UserProvider extends BaseProvider<UserState> {
  final UserService userService;

  UserProvider({required this.userService}) : super(UserState());

  bool get isSession => state.isSession;

  Future<bool> checkSession() async {
    await onGetUser();
    return isSession;
  }

  Future<void> onGetUser() async {
    final res = await userService.getUser();
    onLoading();

    res.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(
          userModel: data,
          isSession: data.name.isNotEmpty,
        ));
        onSuccess();
      },
      err: (err) {
        changeStateWithoutNotify(state.copyWith(
          userModel: null,
          isSession: false,
        ));
        onError(failure: err);
      },
    );
  }

  Future<void> onSetUser({
    required String name,
    required VoidCallback callbackSuccess,
    required VoidCallback callbackError,
  }) async {
    final res = await userService.setUser(userModel: UserModel(name: name));

    onLoading();

    res.capture(
      ok: (data) {
        changeStateWithoutNotify(
          state.copyWith(userModel: data, isSession: true),
        );
        onSuccess();
        callbackSuccess();
      },
      err: (err) {
        changeStateWithoutNotify(
          state.copyWith(userModel: null, isSession: false),
        );
        onError(failure: err);
        callbackError();
      },
    );
  }

  /// function for get list favorite
  Future<void> getFavoriteRestaurant() async {
    changeStateWithoutNotify(state.copyWith(listFavorite: []));
    onLoading();

    final request = await userService.getFavorite();

    request.capture(
      ok: (data) {
        changeStateWithoutNotify(state.copyWith(listFavorite: data));
        onSuccess();
      },
      err: (err) {
        onError(failure: err);
      },
    );
  }
}

class UserState extends BaseState {
  final UserModel? userModel;
  final bool isSession;
  final List<RestaurantModel> listFavorite;

  UserState({
    this.userModel,
    this.isSession = false,
    this.listFavorite = const [],
  });

  UserState copyWith({
    UserModel? userModel,
    bool? isSession,
    List<RestaurantModel>? listFavorite,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      isSession: isSession ?? this.isSession,
      listFavorite: listFavorite ?? this.listFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.userModel == userModel &&
        other.isSession == isSession &&
        listEquals(other.listFavorite, listFavorite);
  }

  @override
  int get hashCode =>
      userModel.hashCode ^ isSession.hashCode ^ listFavorite.hashCode;
}
