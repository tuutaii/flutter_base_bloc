library config;

export 'package:auto_route/auto_route.dart';
export 'package:auto_size_text/auto_size_text.dart';
export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:velocity_x/velocity_x.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

enum Flavor { dev, staging, prod }

class AppConfig {
  AppConfig._();
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

// Change this to your app title
  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flutter Base Bloc (DEV)';
      case Flavor.staging:
        return 'Flutter Base Bloc (STG)';
      default:
        return 'Flutter Base Bloc';
    }
  }

// Change this to your domain
  static String get domain {
    switch (appFlavor) {
      case Flavor.dev:
        return 'flutter.base.bloc.com';
      case Flavor.staging:
        return 'flutter.base.bloc.com';
      default:
        return 'flutter.base.bloc.com';
    }
  }

// Change this to your base url
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://$domain';
      case Flavor.staging:
        return 'https://$domain';
      default:
        return 'https://$domain';
    }
  }
}
