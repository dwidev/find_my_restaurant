import 'package:find_my_restaurant/core/services/failure.dart';

import '../core.dart';

abstract class BaseProvider<State extends BaseState> extends ChangeNotifier {
  BaseProvider(this._state);
  State _state;

  State get state => _state;

  bool get isLoading => state.resultState == ResultState.loading;
  bool get isSuccess => state.resultState == ResultState.success;
  bool get isError => state.resultState == ResultState.error;

  Failure? get errorFailure => state.errorFailure;

  @protected
  set state(State newState) {
    _state = newState;
    notifyListeners();
  }

  @protected
  void changeStateWithoutNotify(State newState) {
    _state = newState;
  }

  void onLoading({bool withNotify = true}) {
    state.resultState = ResultState.loading;
    if (withNotify) {
      notifyListeners();
    }
  }

  void onSuccess({bool withNotify = true}) {
    state.resultState = ResultState.success;
    if (withNotify) {
      notifyListeners();
    }
  }

  void onError({bool withNotify = true, required Failure failure}) {
    state.resultState = ResultState.error;
    state.errorFailure = failure;
    if (withNotify) {
      notifyListeners();
    }
  }
}
