import 'dart:async';
import 'package:flutter/services.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../config.dart';
import 'app_overlay.dart';

class AppUtils {
  static PackageInfo? _deviceInfo;

  static String? appIdBundler;
  static String? versionApp;
  static String? userAgent;
  static Map<String, dynamic> deviceInfo = {};

  static Future<void> getAppInfo() async {
    _deviceInfo = await PackageInfo.fromPlatform();
    appIdBundler = _deviceInfo?.packageName;
    versionApp = _deviceInfo?.version;
  }

  static void onCopy(
    BuildContext context,
    String text,
    String message,
  ) async {
    Clipboard.setData(ClipboardData(text: text)).whenComplete(() {
      AppOverlay.showOverlayNotify(context, content: message);
    });
  }

  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
