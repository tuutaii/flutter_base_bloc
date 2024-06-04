part of 'home_bloc.dart';

abstract class HomeState extends BaseState {}

class IncrementState extends HomeState {
  final int counter;
  IncrementState(this.counter);
  @override
  List<Object?> get props => [counter];
}

class ApiCallSuccessSate extends HomeState {
  final List<dynamic>? data;
  ApiCallSuccessSate(this.data);
  @override
  List<Object?> get props => [data];
}
