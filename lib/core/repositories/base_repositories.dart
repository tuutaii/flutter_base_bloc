library repositories;

import 'package:dio/dio.dart';

import '../bloc/base/base_bloc.dart';
import '../models/base/result.dart';
import '../services/app_service.dart';
import '../utilities/http_client/http_client.dart';

part 'app_repositories.dart';

abstract class BaseRepository {
  Future<Result<Data>> request<Data>(Future<Data> call) async {
    try {
      final response = await call;
      return Success(response);
    } on Exception catch (exception) {
      if (exception is DioException) {
        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            return Error(
              type: ErrorType.timeOut,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );
          case DioExceptionType.cancel:
            return Error(
              type: ErrorType.cancel,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );
          case DioExceptionType.unknown:
            return Error(
              type: ErrorType.other,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );
          case DioExceptionType.connectionError:
            return Error(
              type: ErrorType.noNetwork,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );
          case DioExceptionType.badCertificate:
            return Error(
              type: ErrorType.badCertificate,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );

          case DioExceptionType.badResponse:
            return Error(
              type: ErrorType.response,
              message: exception.message ?? '',
              errorCode: exception.response?.statusCode,
            );
        }
      }

      return Error(
        type: ErrorType.other,
        message: exception.toString(),
      );
    } on Error catch (e) {
      return Error(
        type: e.type,
        message: e.message,
      );
    }
  }
}

class Repositories {
  Repositories._();
  static AppRepository app = AppRepositoryIml();
}
