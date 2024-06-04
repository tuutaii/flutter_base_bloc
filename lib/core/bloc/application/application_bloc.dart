import 'package:flutter/services.dart';
import 'package:flutter_base_bloc/core/extensions/config_extension.dart';

import '../../config.dart';
import '../app_bloc.dart';
import '../base/base_bloc.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends BaseBloc {
  ApplicationBloc() : super(const InitialState());

  @override
  Future<void> onInit(Emitter<BaseState> emit) async {
    emit.call(LoadingState());
    emit.call(const SuccessState(data: 'success'));
    _initializeAppConfig();
  }

  Future<String?> getFlavorSettings() async {
    try {
      const methodChannel = MethodChannel('flavor');
      final flavor = await methodChannel.invokeMethod('flavor');
      return flavor;
    } catch (e) {
      return null;
    }
  }

  Future<void> _initializeAppConfig() async {
    final flavor = await getFlavorSettings();

    AppConfig.appFlavor = flavor.flavor;
    // await AppUtils.getAppInfo();
  }

  @override
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is ApplicationLoading) {
      emit(LoadingState());
    } else if (event is ApplicationLoadingSuccess) {
      emit(LoadingStateSuccess());
    }
  }

  void startLoading() {
    add(ApplicationLoading());
  }

  void endLoading() {
    add(ApplicationLoadingSuccess());
  }
}
