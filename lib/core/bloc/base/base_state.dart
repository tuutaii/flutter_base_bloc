part of 'base_bloc.dart';

enum ErrorType {
  noNetwork,
  tokenExpired,
  timeOut,
  response,
  cancel,
  other,
  badCertificate,
}

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class InitialState extends BaseState {
  const InitialState();
}

class RefreshState extends BaseState {}

class LoadMoreState extends BaseState {}

class LoadMoreSuccess<T> extends BaseState {
  const LoadMoreSuccess({this.data});
  final T? data;
  @override
  List<Object?> get props => [data];
}

class LoadingState extends BaseState {
  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class SuccessState<T> extends BaseState {
  final T? data;

  const SuccessState({this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState extends BaseState {
  const ErrorState({
    this.message = '',
    this.errorType = ErrorType.other,
    this.errorCode,
  });
  final String? message;
  final ErrorType errorType;
  final int? errorCode;
  @override
  List<Object?> get props => [message, errorType, errorCode];
}
