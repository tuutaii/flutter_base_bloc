part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends BaseEvent {}

class RefreshEvent extends BaseEvent {
  const RefreshEvent(this.completer);
  final Completer<void> completer;
}

class LoadMoreEvent extends BaseEvent {}
