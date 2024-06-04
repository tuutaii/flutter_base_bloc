part of 'application_bloc.dart';

abstract class ApplicationEvent extends BaseEvent {}

class ApplicationLoading extends ApplicationEvent {}

class ApplicationLoadingSuccess extends ApplicationEvent {}
