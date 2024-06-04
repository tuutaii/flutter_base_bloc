library dialogs;

import 'dart:async';

import 'package:flutter_base_bloc/core/extensions/context_extension.dart';

import '../../core/config.dart';
import '../core/utilities/app_navigator.dart';
import 'app_button.dart';
import 'loading_indicator.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.textAlign = TextAlign.start,
    this.textOK,
    this.onTap,
    this.willPopScope = true,
  });
  final String title, subtitle;
  final TextAlign textAlign;
  final String? textOK;
  final VoidCallback? onTap;
  final bool willPopScope;
  @override
  Widget build(BuildContext context) {
    final rotateSize =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? Size(context.screenHeight.h - 32, 48.h)
            : null;
    return WillPopScope(
      onWillPop: () => Future.value(willPopScope),
      child: Dialog(
        insetPadding:
            EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title.isNotEmptyAndNotNull)
                Text(
                  title,
                  style: context.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                text: textOK ?? 'OK',
                color: Colors.black,
                borderRadius: 4,
                size: rotateSize,
                onPressed: onTap,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppDialog {
  AppDialog._();

  static void showLoading() {
    AppNavigator.currentContext.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: const LoadingIndicator(color: Colors.white),
      ),
    );
  }
}
