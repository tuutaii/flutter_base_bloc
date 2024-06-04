import 'package:dio/dio.dart';

import '../../config.dart';
import 'dio_custom_interceptor.dart';

enum ApiMethod { get, post, put, delete, patch, head }

class ApiClient<T> {
  ApiClient._internal();

  static String? authentication;
  static const Duration connectTimeOut = Duration(seconds: 40);
  static const Duration receiveTimeOut = Duration(seconds: 40);

  static const methodMap = {
    ApiMethod.get: 'get',
    ApiMethod.post: 'post',
    ApiMethod.put: 'put',
    ApiMethod.delete: 'delete',
    ApiMethod.patch: 'patch',
    ApiMethod.head: 'head',
  };
  static Dio get dio => _dio;
  static final _dio = Dio()
    ..options.baseUrl = AppConfig.baseUrl
    ..options.connectTimeout = connectTimeOut
    ..options.receiveTimeout = receiveTimeOut
    ..options.followRedirects = false
    ..interceptors.add(CustomInterceptors());

  static void openLog() => _dio.interceptors.add(LogInterceptor());

  static void setBaseUrl(String url) => _dio.options.baseUrl = url;

  static void setConnectTimeOut(int? val) {
    _dio.options.connectTimeout = Duration(milliseconds: val ?? 0);
  }

  static void setHeader(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  static void removeHeader(String header) {
    _dio.options.headers.remove(header);
  }
}
