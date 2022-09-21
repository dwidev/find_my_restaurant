import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';
import 'http_failure.dart';
import 'result.dart';

/// class for base service
abstract class BaseService with Guards {
  final Dio client;

  BaseService({required this.client}) {
    client.options = BaseOptions(
      baseUrl: "https://restaurant-api.dicoding.dev",
      connectTimeout: 10000, // 10 seconds
      receiveTimeout: 5000, // 5 seconds
    );
  }

  /// function for request get method
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.get(path, queryParameters: queryParameters);
    return response;
  }
}

mixin Guards {
  /// function for try cache
  Future<Result<S, Failure>> guards<S>({
    required Future<Result<S, Failure>> Function() process,
  }) async {
    try {
      return await process();
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode ?? 0;

      if (e.error is SocketException) {
        return Error(InternetConnectionFailure());
      }

      if (e.type == DioErrorType.connectTimeout) {
        return Error(ConnectionTimeoutFailure());
      }

      if (statusCode >= 400 && statusCode < 500) {
        return Error(ClientErrorFailure(statusCode));
      }

      if (statusCode >= 500 && statusCode < 600) {
        return Error(InternalServerErrorFailure(statusCode));
      }

      return Error(UnknownFailure(e.message));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
