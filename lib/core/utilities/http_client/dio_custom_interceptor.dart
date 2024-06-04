import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../config.dart';
import '../debug_print.dart';

const _logger = false;
const _loggerRequest = false;
const _loggerResponse = false;

class RefreshTokenData {
  final Response response;
  final ResponseInterceptorHandler handler;

  RefreshTokenData(
    this.response,
    this.handler,
  );
}

class RequestQueue {
  final Completer<RequestOptions> completer;
  final Function(Response res)? onResponse;
  RequestQueue(this.completer, {this.onResponse});
}

class CustomInterceptors extends Interceptor {
  CustomInterceptors._();

  static final CustomInterceptors _instance = CustomInterceptors._();

  factory CustomInterceptors() => _instance;

  static CustomInterceptors get instance => _instance;

// list queue request if token expired
  List<RequestQueue> requestQueue = [];

  bool isRefreshingToken = false;
  bool isExpiredToken = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    bool isToken = options.headers['Authorization']?.isNotEmpty ?? false;

    if (_logger || _loggerRequest) {
      AppPrint.print(
        'REQUEST[${options.method}] => PATH: ${options.uri}, Data: ${options.data} , header ${options.headers}',
        tag: 'onRequest',
      );
    }
    // check if request new token await to finish and set new token
    if (isExpiredToken && isToken) {
      final completer = Completer<RequestOptions>();
      requestQueue.add(RequestQueue(completer, onResponse: (res) {
        handler.resolve(res);
      }));
      final requestOptions = await completer.future;
      return super.onRequest(requestOptions, handler);
    } else {
      return super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final url = response.requestOptions.uri.toString();

    if (_logger || _loggerResponse) {
      AppPrint.print(
        'RESPONSE[${response.statusCode}] => PATH: $url ,Data: ${jsonEncode(response.data)}',
        tag: 'onResponse',
      );
    }

    // check response data is string and not empty then decode to json
    if (response.data is String) {
      if ((response.data as String).isNotEmptyAndNotNull) {
        response.data = jsonDecode(response.data);
      }
    }
    // check response data is map
    if (response.data is Map<String, dynamic>) {
      try {
        return super.onResponse(response, handler);
      } catch (e) {
        AppPrint.print(e, tag: 'refreshToken');
      }
    }
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    AppPrint.print(
      'msg: ${err.message} - type: ${err.type} - error: ${err.error} - response: ${err.response} - url: ${err.requestOptions.uri} - header:${err.requestOptions.headers}}}}',
      tag: 'onError',
    );
    super.onError(err, handler);
  }
}

class RenewInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_logger || _loggerRequest) {
      AppPrint.print(
        'REQUEST[${options.method}] => PATH: ${options.uri}, Data: ${options.data} , header ${options.headers}',
        tag: 'RenewInterceptor',
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_logger || _loggerResponse) {
      final url = response.requestOptions.uri;
      AppPrint.print(
        'RESPONSE[${response.statusCode}] => PATH: $url ,Data: ${jsonEncode(response.data)}',
        tag: 'RenewInterceptor',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    AppPrint.print(
      'msg: ${err.message} - type: ${err.type} - error: ${err.error} - response: ${err.response} - url: ${err.requestOptions.uri} - header:${err.requestOptions.headers}}}}',
      tag: 'RenewInterceptor',
    );
    super.onError(err, handler);
  }
}
