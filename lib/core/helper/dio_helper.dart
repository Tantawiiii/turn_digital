import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:turn_digital/core/constant/apis_const.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApisClient.BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      // requestBody: true,
      // responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ),
  );

  static Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await _dio.get(url, queryParameters: queryParams);
      return response;
    } catch (e) {
      return null;
    }
  }
}
