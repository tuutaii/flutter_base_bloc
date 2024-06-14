import '../core/config.dart';
import '../screens/chat_box_screen.dart';
import '../screens/home.dart';
import '../screens/screen_navigate.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/home', page: HomeRoute.page, initial: true),
        AutoRoute(path: '/navigate', page: NavigateRoute.page),
        AutoRoute(path: '/chatBoxScreen', page: ChatBoxRoute.page),
      ];
}
