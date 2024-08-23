import 'package:json_annotation/json_annotation.dart';

import 'api_exceptions.dart';

part 'model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  final T? data;
  final int errorCode;
  final String errorMsg;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ApiException? error; // 添加注解指定：序列化和反序列化时忽略这个字段

  DataResponse({required this.data, required this.errorCode, required this.errorMsg, this.error});

  factory DataResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      _$DataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) => _$DataResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'DataResponse{data: $data, errorCode: $errorCode, errorMsg: $errorMsg, error: $error}';
  }
}

// Data是列表
@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  final List<T>? data;
  final int errorCode;
  final String errorMsg;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ApiException? error; // 添加注解指定：序列化和反序列化时忽略这个字段

  ListResponse({required this.data, required this.errorCode, required this.errorMsg, this.error});

  factory ListResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) =>
      _$ListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) => _$ListResponseToJson(this, toJsonT);
}

@JsonSerializable()
class IndexBanner {
  final String title;
  final String imagePath;
  final String url;

  IndexBanner({
    required this.title,
    required this.imagePath,
    required this.url,
  });

  factory IndexBanner.fromJson(Map<String, dynamic> json) => _$IndexBannerFromJson(json);

  Map<String, dynamic> toJson() => _$IndexBannerToJson(this);
}

@JsonSerializable()
class Article {
  final int page;
  final String keyword;

  Article({
    required this.page,
    required this.keyword,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  // 重写toString()
  @override
  String toString() {
    return 'Article{page: $page, keyword: $keyword}';
  }
}
