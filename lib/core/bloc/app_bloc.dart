import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/bloc/home_bloc/home_bloc.dart';

import '../utilities/app_navigator.dart';
import 'app_bloc.dart';
import 'application/application_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

export 'app_bloc_observer.dart';

class AppBloc {
  AppBloc._();

  static BuildContext get dashboardContext =>
      AppNavigator.dashboardKey.currentContext!;

  //bloc global app
  static final application = ApplicationBloc();
  static final home = HomeBloc();
  //end global app

  static final providers = [
    BlocProvider<ApplicationBloc>(create: (_) => application),
    BlocProvider<HomeBloc>(create: (_) => home),
  ];

  static void dispose() {
    application.close();
    home.close();
  }
}
