import 'dart:async';

import 'package:flutter_base_bloc/core/extensions/context_extension.dart';

import '../config.dart';

class AppOverlay {
  AppOverlay._();
  factory AppOverlay() => _instance;
  static final AppOverlay _instance = AppOverlay._();

  bool showedToastOverlay = false;
  bool showedDialogOverlay = false;
  bool showedLoadingOverlay = false;

  OverlayEntry? overlayToastEntry;
  OverlayEntry? overlayDialogEntry;
  OverlayEntry? overlayLoadingEntry;
  Timer? timer;

  static void removeOverlayToastNotify() {
    _instance.overlayToastEntry?.remove();
    _instance.overlayToastEntry = null;
    _instance.timer?.cancel();
    _instance.timer = null;

    _instance.showedToastOverlay = false;
  }

  static void showOverlayNotify(
    BuildContext context, {
    required String content,
    int duration = 1,
  }) {
    if (_instance.showedToastOverlay) {
      removeOverlayToastNotify();
    }
    _instance.overlayToastEntry = OverlayEntry(
      builder: (BuildContext context) {
        return UnconstrainedBox(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: context.width - (16.w * 2),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black.withOpacity(0.8),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: 12.h,
            ),
            child: Text(
              content,
              style: context.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_instance.overlayToastEntry!);
    _instance.showedToastOverlay = true;

    _instance.timer = Timer.periodic(Duration(seconds: duration), (timer) {
      removeOverlayToastNotify();
      timer.cancel();
    });
  }

  static void removeOverlayDialogNotify() {
    _instance.overlayDialogEntry?.remove();
    _instance.overlayDialogEntry = null;
    _instance.showedDialogOverlay = false;
  }

  static void showDialogOverlay(BuildContext context, {required Widget child}) {
    if (_instance.showedDialogOverlay) {
      removeOverlayDialogNotify();
    }

    _instance.overlayDialogEntry = OverlayEntry(
      builder: (BuildContext context) {
        return child;
      },
    );
    Overlay.of(context).insert(_instance.overlayDialogEntry!);
    _instance.showedDialogOverlay = true;
  }

  static void removeOverlayLoading() {
    _instance.overlayLoadingEntry?.remove();
    _instance.overlayLoadingEntry = null;
    _instance.showedLoadingOverlay = false;
  }

  static void showLoadingOverlay(BuildContext context) {
    if (_instance.showedLoadingOverlay) {
      removeOverlayLoading();
    }

    _instance.overlayLoadingEntry = OverlayEntry(
      builder: (BuildContext context) {
        return const Center(
          child: ColoredBox(
            color: Colors.black54,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      },
    );
    Overlay.of(context).insert(_instance.overlayLoadingEntry!);
    _instance.showedLoadingOverlay = true;
  }
}
