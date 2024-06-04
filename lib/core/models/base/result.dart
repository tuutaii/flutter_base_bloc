import '../../bloc/base/base_bloc.dart';

class Result<T> extends SealedResult<T> {}

class Success<T> extends Result<T> {
  T? data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  int? errorCode;
  ErrorType type;
  String message;

  Error({required this.type, required this.message, this.errorCode});

  bool get isTokenExpired => type == ErrorType.tokenExpired;

  bool get isTimeOut => type == ErrorType.timeOut;
}

abstract class SealedResult<T> {
  R? when<R>({
    R Function(T? data)? success,
    R Function(ErrorType type, int? code, String error)? error,
  }) {
    if (this is Success<T?>) {
      return success?.call((this as Success).data);
    }
    if (this is Error<T>) {
      return error?.call(
        (this as Error<T>).type,
        (this as Error<T>).errorCode,
        (this as Error<T>).message.toString(),
      );
    } else {
      return error?.call(ErrorType.other, null, toString());
    }
  }
}
