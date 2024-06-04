import 'package:dio/dio.dart';
import 'package:flutter_base_bloc/core/bloc/base/base_bloc.dart';
import 'package:flutter_base_bloc/core/models/quote_model/quote_model.dart';
import 'package:flutter_base_bloc/core/utilities/debug_print.dart';

import '../app_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc {
  HomeBloc() : super(const InitialState());

  int counter = 0;
  List<Quote>? data;

  @override
  @override
  Future<void> handleEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is IncrementEvent) {
      counter++;
      emit(IncrementState(counter));
    } else if (event is ApiCallSuccessEvent) {
      emit(ApiCallSuccessSate(data));
    }
  }

  Future<void> onIncrement() async {
    add(IncrementEvent());
  }

  Future<void> onCallApi() async {
    var dio = Dio();
    try {
      AppBloc.application.startLoading();
      final response = await dio.get('https://dummyjson.com/quotes');
      if (response.statusCode == 200) {
        data = QuoteList.fromJson(response.data).quotes;
        add(ApiCallSuccessEvent());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      AppPrint.print(e);
    }
    AppBloc.application.endLoading();
  }
}
