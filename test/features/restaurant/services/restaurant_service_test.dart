import 'dart:io';

import 'package:dio/dio.dart';
import 'package:find_my_restaurant/core/services/http_failure.dart';
import 'package:find_my_restaurant/features/restaurant/data/model/restaurant_model.dart';
import 'package:find_my_restaurant/features/restaurant/services/restaurant_service.dart';
import 'package:find_my_restaurant/features/user/preferences/user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class UserPreferenceMock extends Mock implements UserPreference {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late UserPreferenceMock userPreferenceMock;
  late RestaurantService restaurantService;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    userPreferenceMock = UserPreferenceMock();
    restaurantService = RestaurantServiceImpl(
      client: dio,
      userPreference: userPreferenceMock,
    );
  });

  group("should test restaurant service", () {
    const listPath = "/list";
    const reviewPath = "/review";

    test("get list restaurant is internal server no internet connection",
        () async {
      final dioError = DioError(
        error: const SocketException("failed connect"),
        requestOptions: RequestOptions(path: listPath),
      );

      dioAdapter.onGet(listPath, (server) {
        server.throws(500, dioError);
      });

      final response = await restaurantService.getListResto();

      final actual = response.capture(ok: (ok) => ok, err: (err) => err);

      expect(actual, isA<InternetConnectionFailure>());
    });

    test("get list restaurant is internal server error", () async {
      dioAdapter.onGet(listPath, (server) {
        server.reply(500, {"message": "internal server error"});
      });

      final response = await restaurantService.getListResto();

      final actual = response.capture(ok: (ok) => ok, err: (err) => err);

      expect(actual, isA<InternalServerErrorFailure>());
    });

    test("get list restaurant is empty", () async {
      final responseJson = {
        "error": false,
        "message": "success",
        "count": 0,
        "restaurants": []
      };

      dioAdapter.onGet(listPath, (server) {
        server.reply(200, responseJson);
      });

      final response = await restaurantService.getListResto();

      final actual = response.capture(ok: (ok) => ok.length, err: (err) => err);
      expect(actual, 0);
    });

    test("get list restaurant return type is List<RestaurantModel>", () async {
      final responseJson = {
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "test",
            "name": "test",
            "description": "test",
            "pictureId": "test",
            "city": "test",
            "rating": 5
          },
        ]
      };

      dioAdapter.onGet(listPath, (server) {
        server.reply(200, responseJson);
      });

      final response = await restaurantService.getListResto();

      final actual = response.capture(ok: (ok) => ok, err: (err) => err);
      expect(actual, isA<List<RestaurantModel>>());
    });

    test("add review restaurant should success", () async {
      final data = {
        "id": "test-id",
        "name": "test name",
        "review": "test review",
      };

      final responseJson = {
        "error": false,
        "message": "success",
        "customerReviews": [
          {
            "name": "test-id",
            "review": "test name",
            "date": "27 September 2022"
          },
        ]
      };

      dioAdapter.onPost(
        reviewPath,
        (server) {
          server.reply(201, responseJson);
        },
        data: data,
      );

      final response = await restaurantService.addReviewByUser(
        restoId: "test-id",
        name: "test name",
        review: "test review",
      );

      final actual = response.capture(ok: (ok) => ok.length, err: (err) => err);

      expect(actual, 1);
    });
  });
}
