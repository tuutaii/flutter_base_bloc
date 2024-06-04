import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseModel<T> {
  final String? requestId;
  final String? desc;
  final String? message;
  final int? status;
  final T? data;
  final dynamic error;

  BaseModel({
    this.requestId,
    this.status,
    this.desc,
    this.message,
    this.data,
    this.error,
  });

  bool isSuccess() => status == 200;

  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseModelFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$BaseModelToJson<T>(this, toJsonT);
}

class PaginatorBase<T, B> {
  int page;
  int pageSize;
  int totalItems;
  List<T> items;
  B request;
  bool canLoadMore;
  CancelToken? cancelToken;
  PaginatorBase({
    this.page = 1,
    this.pageSize = 20,
    this.totalItems = 1,
    this.canLoadMore = false,
    this.items = const [],
    this.cancelToken,
    required this.request,
  });

  bool get hasMoreToLoad => items.length < totalItems;
}
