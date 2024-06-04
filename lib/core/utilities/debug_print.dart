import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import '../config.dart';

class AppPrint {
  AppPrint._();
  static void print(dynamic msg, {String? tag}) {
    if (kDebugMode) {
      developer.log(msg.toString(), name: tag ?? AppConfig.title);
    }
  }
}
