part of 'home_bloc.dart';

abstract class HomeEvent extends BaseEvent {}

class IncrementEvent extends HomeEvent {}

class ApiCallSuccessEvent extends HomeEvent {}
