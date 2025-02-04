import 'package:cinemania/core/constants/constants.dart';
import 'package:cinemania/core/logging/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConfig {
  static Dio createDio() {
    final String apiKey = dotenv.env['API_KEY'] ?? '';

    final dio = Dio(BaseOptions(
      baseUrl: Constants.apiMovieDBBaseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {"Authorization": "Bearer $apiKey"},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        AppLogger.info("API Request: ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger.info("API Response: ${response.statusCode} ${response.requestOptions.uri}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        AppLogger.error("API Error: ${e.message}", error: e, stackTrace: e.stackTrace);
        return handler.next(e);
      },
    ));

    return dio;
  }
}
