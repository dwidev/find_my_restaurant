import 'package:flutter_test/flutter_test.dart';

import 'package:find_my_restaurant/core/core.dart';
import 'package:find_my_restaurant/core/services/failure.dart';

class SomeProvider extends BaseProvider {
  SomeProvider() : super(SomeState());
}

class SomeState extends BaseState {}

void main() {
  late SomeProvider provider;

  setUp(() {
    provider = SomeProvider();
  });

  group("should test base provider :", () {
    test("state result should initial", () {
      expect(provider.state.resultState, ResultState.initial);
    });

    test("state result should loading", () {
      provider.onLoading();

      expect(provider.state.resultState, ResultState.loading);
    });

    test("state result should success", () {
      provider.onSuccess();

      expect(provider.state.resultState, ResultState.success);
    });

    test("state result should error", () {
      provider.onError(failure: UnknownFailure(""));

      expect(provider.state.resultState, ResultState.error);
    });
  });
}
