import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_base_bloc/core/models/base/base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/base/result.dart';

part 'base_event.dart';
part 'base_state.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(BaseState state) : super(state) {
    on<BaseEvent>(
      (event, emit) async {
        if (event is InitialEvent) {
          await onInit(emit);
        } else {
          await handleEvent(event, emit);
        }
      },
    );
  }
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {}

  Future<void> onInit(Emitter<BaseState> emit) async {}

  /// Custom request API with your base API
  Future<void> requestApi<T>({
    Emitter<BaseState>? emit,
    Function(Emitter<BaseState>? emit, T? data)? onSuccess,
    Function(Emitter<BaseState>? emit)? loading,
    Function(Emitter<BaseState>? emit, String message)? onError,
    required Future<Result<T>> callToHost,
  }) async {
    loading != null ? loading.call(emit) : emit?.call(LoadingState());
    try {
      (await callToHost).when(
        success: (data) {
          if (onSuccess == null) {
            emit?.call(SuccessState(data: data));
            return;
          } else {
            if (data is BaseModel) {
            } else {
              onSuccess.call(emit, data);
            }
          }
        },
        error: (ErrorType type, int? code, message) {
          onError != null
              ? onError.call(emit, message)
              : emit?.call(
                  ErrorState(
                    message: message,
                    errorType: type,
                    errorCode: code,
                  ),
                );
        },
      );
    } on Error catch (e) {
      onError != null
          ? onError.call(emit, e.toString())
          : emit?.call(ErrorState(message: e.toString()));
    }
  }
}
