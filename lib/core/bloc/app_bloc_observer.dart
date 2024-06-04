import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilities/debug_print.dart';

class AppBlocObserver extends BlocObserver {
  bool isLogger = false;
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (isLogger) {
      AppPrint.print('onEvent $event', tag: '$bloc');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (isLogger) {
      AppPrint.print('onChange $change', tag: '$bloc');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (isLogger) {
      AppPrint.print('onTransition $transition', tag: '$bloc');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (isLogger) {
      AppPrint.print('onError $error', tag: '$bloc');
    }
  }
}
