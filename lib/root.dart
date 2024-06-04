import 'package:flutter_base_bloc/widgets/loading_indicator.dart';

import 'core/bloc/app_bloc.dart';
import 'core/bloc/application/application_bloc.dart';
import 'core/bloc/base/base_bloc.dart';
import 'core/config.dart';
import 'core/utilities/app_navigator.dart';
import 'core/utilities/app_utils.dart';
import 'core/utilities/debug_print.dart';
import 'core/utilities/language.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, Widget? child) {
        return AppBlocBuilder(
          builder: (context, auth) {
            return GestureDetector(
              onTap: () {
                ContextMenuController.removeAny();
                AppUtils.unfocus();
              },
              child: MaterialApp.router(
                title: AppConfig.title,
                debugShowCheckedModeBanner: false,
                showPerformanceOverlay: false,
                supportedLocales: AppLanguage.supportLanguage,
                routerDelegate: AppNavigator.appRouter.delegate(
                  navigatorObservers: () => [MyObserver()],
                ),
                routeInformationParser:
                    AppNavigator.appRouter.defaultRouteParser(),
                builder: (context, child) {
                  return Overlay(
                    initialEntries: [
                      OverlayEntry(
                        builder: (_) => AppBuilder(
                          child: child!,
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Stack(
        children: [
          child,
          const _LoadingApp(),
        ],
      ),
    );
  }
}

class _LoadingApp extends StatelessWidget {
  const _LoadingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loading =
        context.select((ApplicationBloc bloc) => bloc.state is LoadingState);

    return loading
        ? const ColoredBox(
            color: Colors.black54,
            child: LoadingIndicator(color: Colors.white),
          )
        : const SizedBox();
  }
}

class MyObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    ContextMenuController.removeAny();
    AppPrint.print(route.settings.name, tag: 'didPop');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    ContextMenuController.removeAny();
    AppPrint.print(route.settings.name, tag: 'didPush');
    super.didPush(route, previousRoute);
  }
}

class AppBlocBuilder extends StatelessWidget {
  const AppBlocBuilder({Key? key, required this.builder}) : super(key: key);
  final BlocWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<ApplicationBloc, BaseState>(
        buildWhen: (previous, current) => current is SuccessState,
        builder: (context, state) {
          return BlocBuilder<ApplicationBloc, BaseState>(
            builder: builder,
          );
        },
      ),
    );
  }
}
