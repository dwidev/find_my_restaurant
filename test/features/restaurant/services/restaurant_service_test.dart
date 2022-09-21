import 'package:find_my_restaurant/core/services/failure.dart';
import 'package:find_my_restaurant/core/services/http_failure.dart';
import 'package:find_my_restaurant/core/services/result.dart';
import 'package:find_my_restaurant/features/restaurant/data/model/restaurant_model.dart';
import 'package:find_my_restaurant/features/restaurant/services/restaurant_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RestaurantServiceMock extends Mock implements RestaurantService {}

void main() {
  late RestaurantServiceMock restaurantServiceMock;

  setUp(() {
    restaurantServiceMock = RestaurantServiceMock();
  });

  group("should test restaurant service", () {
    test("get list restaurant is internal server no internet connection",
        () async {
      when(() => restaurantServiceMock.getListResto()).thenAnswer(
        (invocation) => Future.value(
          Result.error(InternetConnectionFailure()),
        ),
      );

      final response = await restaurantServiceMock.getListResto();

      late Failure actual;

      response.capture(
        ok: (ok) {},
        err: (err) {
          actual = err;
        },
      );

      expect(actual, isA<InternetConnectionFailure>());
    });

    test("get list restaurant is internal server error", () async {
      when(() => restaurantServiceMock.getListResto()).thenAnswer(
        (invocation) => Future.value(
          Result.error(InternalServerErrorFailure(500)),
        ),
      );

      final response = await restaurantServiceMock.getListResto();

      late Failure actual;

      response.capture(
        ok: (ok) {},
        err: (err) {
          actual = err;
        },
      );

      expect(actual, isA<InternalServerErrorFailure>());
    });

    test("get list restaurant is empty", () async {
      when(() => restaurantServiceMock.getListResto()).thenAnswer(
        (invocation) => Future.value(Result.ok([])),
      );

      final response = await restaurantServiceMock.getListResto();

      List<RestaurantModel> actual = [];

      response.capture(
        ok: (ok) {
          actual = ok;
        },
        err: (err) {},
      );

      expect(actual.length, 0);
    });

    test("get list restaurant return type is List<RestaurantModel>", () async {
      when(() => restaurantServiceMock.getListResto()).thenAnswer(
        (invocation) => Future.value(Result.ok([])),
      );

      final response = await restaurantServiceMock.getListResto();

      late List<RestaurantModel> actual;

      response.capture(
        ok: (ok) {
          actual = ok;
        },
        err: (err) {},
      );

      expect(actual, isA<List<RestaurantModel>>());
    });
  });
}
