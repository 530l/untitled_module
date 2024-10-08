// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse<T> _$DataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DataResponse<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      errorCode: (json['errorCode'] as num).toInt(),
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$DataResponseToJson<T>(
  DataResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

ListResponse<T> _$ListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListResponse<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      errorCode: (json['errorCode'] as num).toInt(),
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$ListResponseToJson<T>(
  ListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

IndexBanner _$IndexBannerFromJson(Map<String, dynamic> json) => IndexBanner(
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$IndexBannerToJson(IndexBanner instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imagePath': instance.imagePath,
      'url': instance.url,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      page: (json['page'] as num).toInt(),
      keyword: json['keyword'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'page': instance.page,
      'keyword': instance.keyword,
    };
