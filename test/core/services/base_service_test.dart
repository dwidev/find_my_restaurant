import 'package:dio/dio.dart';
import 'package:find_my_restaurant/core/services/base_service.dart';
import 'package:find_my_restaurant/core/services/failure.dart';
import 'package:find_my_restaurant/core/services/result.dart';
import 'package:flutter_test/flutter_test.dart';

class SomeService extends BaseService {
  SomeService() : super(client: Dio());
}

void main() {
  late BaseService service;

  setUp(() {
    service = SomeService();
  });

  group("should test base service : ", () {
    test("guards result with type Result", () async {
      final matcher = await service.guards(process: () async {
        return Ok(null);
      });

      expect(matcher, isA<Result>());
    });

    test("guards result with ok", () async {
      final matcher = await service.guards(process: () async {
        return Ok("ok");
      });

      expect(matcher.capture(ok: (ok) => ok, err: (e) {}), "ok");
    });

    test("guards result with failure", () async {
      final matcher = await service.guards(process: () async {
        return Error(UnknownFailure(""));
      });

      expect(matcher.capture(ok: (ok) {}, err: (e) => e), UnknownFailure(""));
    });
  });
}
