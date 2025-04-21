import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioFactory {
  const DioFactory();

  static const String _baseUrl = "https://api.themoviedb.org/3/";

  Dio createClient() {
    final Dio dio = Dio(_createBaseOptions())
      ..interceptors.add(AuthInterceptor());

    if (!kReleaseMode) {
      dio.interceptors.add(DebugLoggingInterceptor());
    }

    return dio;
  }

  BaseOptions _createBaseOptions() => BaseOptions(
    baseUrl: _baseUrl,
    receiveTimeout: const Duration(milliseconds: 10000),
    sendTimeout: const Duration(milliseconds: 10000),
    connectTimeout: const Duration(milliseconds: 5000),
    headers: <String, dynamic>{"Accept": "application/json"},
  );
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['api_key'] = "a794ee27f47722d30bc1c67e3df3522a";
    super.onRequest(options, handler);
  }
}

class DebugLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("---> ON REQUEST");
    log("${options.method}:${options.uri.toString()}");
    log(options.headers.toString());
    log((options.data.toString()));
    log("<--- ON REQUEST");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("---> ON ERROR");
    log("${err.response?.statusCode} ${(err.response?.requestOptions)}");
    log("Response: ${err.response?.data}");
    log("<--- ON ERROR");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("---> ON RESPONSE");
    log("${response.statusCode} ${(response.requestOptions)}");
    log("Response: ${response.data}");
    log("<--- ON RESPONSE");
    super.onResponse(response, handler);
  }
}
