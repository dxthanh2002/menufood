import 'package:ai_menu_flutter/utils/constants.dart';
import 'package:dio/dio.dart';

import '../utils/console.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Console.error('''
        --Status: ${err.response?.statusCode}
        --Error: ${err.message}
    ''');

    handler.next(err);
  }
}

final api = Dio(
  BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ),
)..interceptors.add(LoggingInterceptor());
