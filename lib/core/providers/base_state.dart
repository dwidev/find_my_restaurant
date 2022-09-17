import 'package:find_my_restaurant/core/services/failure.dart';

enum ResultState { initial, loading, success, error }

abstract class BaseState {
  ResultState resultState;
  Failure? errorFailure;

  BaseState({this.resultState = ResultState.initial, this.errorFailure});
}
