import '../../routes/app_router.dart';
import '../config.dart';
import 'app_overlay.dart';

class AppNavigator {
  AppNavigator._();
  factory AppNavigator() => _instance;
  static final AppNavigator _instance = AppNavigator._();

  static final appKey = GlobalKey();

  static final globalKey = GlobalKey<NavigatorState>();
  static final dashboardKey = GlobalKey<NavigatorState>();

  static final appRouter = AppRouter();

  static BuildContext get currentContext =>
      globalKey.currentContext ?? appKey.currentContext!;

  static void showToast(String msg) {
    AppOverlay.showOverlayNotify(currentContext, content: msg);
  }

  static void showToastError(String msg, int duration) {
    AppOverlay.showOverlayNotify(currentContext,
        content: msg, duration: duration);
  }

//Custom func for navigate to any screen
  static void navigateToScreen() {
    appRouter.navigate(const NavigateRoute());
  }
}
