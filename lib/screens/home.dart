import 'package:flutter_base_bloc/core/bloc/app_bloc.dart';
import 'package:flutter_base_bloc/core/bloc/base/base_bloc.dart';
import 'package:flutter_base_bloc/core/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_base_bloc/core/utilities/app_navigator.dart';

import '../core/config.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<HomeBloc, BaseState>(
              bloc: _homeBloc,
              builder: (context, state) {
                if (state is IncrementState) {
                  return Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return Text(
                  '${_homeBloc.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            BlocBuilder<HomeBloc, BaseState>(
              bloc: _homeBloc,
              builder: (context, state) {
                return _homeBloc.data == null
                    ? Text(
                        'No data found',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )
                    : SizedBox(
                        height: context.screenHeight * .3,
                        child: ListView.builder(
                          itemCount: _homeBloc.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _homeBloc.data?[index].quote ?? '',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '---- ${_homeBloc.data?[index].author ?? ''} ----',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: context.backgroundColor),
                                  maxLines: 4,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            );
                          },
                        ),
                      );
              },
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _homeBloc.onIncrement,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    AppBloc.application.startLoading();
                    Future.delayed(const Duration(seconds: 2)).then((value) {
                      AppBloc.application.endLoading();
                    });
                  },
                  child: const Text('Loading'),
                ),
                const ElevatedButton(
                  onPressed: AppNavigator.navigateToScreen,
                  child: Text('Navigate'),
                ),
                ElevatedButton(
                  onPressed: _homeBloc.onCallApi,
                  child: const Text('Rest API'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
