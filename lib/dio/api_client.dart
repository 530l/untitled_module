import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'api_exceptions.dart';
import 'interceptors.dart';
import 'model.dart';

/// 请求操作封装
class ApiClient {
  late final Dio _dio;
  static ApiClient? _instance;

  // 私有命名构造函数
  ApiClient._internal(this._dio) {
    // 添加通用的默认拦截器
    _dio.interceptors.add(DefaultInterceptorsWrapper());
    if (kDebugMode) {
      // 添加请求日志拦截器，控制台可以看到请求日志
      _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      // 启用本地抓包代理，使用Charles等抓包工具可以抓包
      _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: localProxyHttpClient);
    }
  }

  /// ！！！单例初始化方法，需要在实例化前调用
  /// [baseUrl] 接口基地址
  /// [requestHeaders] 请求头
  static Future<void> init(String baseUrl, {Map<String, String>? requestHeaders}) async {
    _instance ??= ApiClient._internal(
      Dio(
        BaseOptions(
          baseUrl: baseUrl,
          responseType: ResponseType.json,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: requestHeaders ?? await _defaultRequestHeaders,
          // 请求是否成功的判断，返回false，会抛出DioError异常，类型为 DioErrorType.RESPONSE
          // 默认接收200-300间的状态码作为成功的请求，不想抛出异常，直接返回true
          validateStatus: (status) => true,
        ),
      ),
    );
  }

  // 暴露实例供外部访问
  static ApiClient get instance {
    if (_instance == null) {
      throw Exception('APIService is not initialized, call init() first');
    }
    return _instance!;
  }

  /// 构造默认请求头
  static Future<Map<String, dynamic>?> get _defaultRequestHeaders async {
    Map<String, dynamic> headers = {};
    return headers;
  }

  /// 更新请求头
  void updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// 通用请求封装
  /// [R] data 对应的响应类型，[D] Model类对应的类型
  /// [dioCall] 异步请求，[fromJsonT] 响应实体类的fromJson()闭包
  Future<R> _performRequest<R, D>(Future<Response> Function() dioCall, D Function(dynamic json)? fromJsonT) async {
    try {
      // 执行请求，获取响应
      Response response = await dioCall();
      // 如果没有设置fromJsonT或者R是dynamic类型，直接返回响应数据
      if (fromJsonT == null || R == dynamic || response.data is! Map<String, dynamic>) return response.data;
      Map<String, dynamic>? responseObject = response.data;
      if (response.statusCode == 200 && responseObject != null && responseObject.isEmpty == false) {
        switch (responseObject['errorCode']) {
          case 200:
            if (R.toString().contains("DataResponse")) {
              return DataResponse<D>.fromJson(responseObject, fromJsonT) as R;
            } else if (R.toString().contains("ListResponse")) {
              return ListResponse<D>.fromJson(responseObject, fromJsonT) as R;
            } else {
              throw NotKnowResponseTypeException(-1, '未知响应类型【${R.toString()}】，请检查是否未正确设置响应类型！');
            }
          case 105:
            throw NeedLoginException(-1, "需要登录");
          case 219:
            throw NeedLoginException(-1, "应用需要强更");
          default:
            throw ApiException(responseObject['errorCode'], responseObject['errorMsg']);
        }
      } else {
        throw ApiException(-1, "错误响应格式");
      }
    } catch (e) {
      var exception = ApiException.from(e);
      if (R.toString().contains("DataResponse")) {
        return DataResponse<D>(
            data: null, errorCode: exception.code ?? -1, errorMsg: exception.message ?? "未知异常", error: exception) as R;
      } else if (R.toString().contains("ListResponse")) {
        return ListResponse<D>(
            data: null, errorCode: exception.code ?? -1, errorMsg: exception.message ?? "未知异常", error: exception) as R;
      } else {
        throw exception;
      }
    }
  }

  /// 执行GET请求
  ///
  /// [endpoint] 接口地址 例如：/api/v1/user
  /// [fromJsonT] 响应实体类的fromJson()闭包
  /// [queryParameters] 请求参数
  /// [options] 请求配置
  /// [cancelToken] 取消请求的token
  /// [fromJsonT] 响应实体类的fromJson()闭包
  Future<R> get<R, D>(String endpoint,
          {D Function(dynamic json)? fromJsonT,
          Map<String, dynamic>? queryParameters,
          Options? options,
          CancelToken? cancelToken}) =>
      _performRequest<R, D>(
          () => _dio.get(endpoint, queryParameters: queryParameters, options: options, cancelToken: cancelToken),
          fromJsonT);

  /// 执行POST请求
  /// [endpoint] 接口地址
  /// [fromJsonT] 响应实体类的fromJson()闭包
  /// [data] 请求数据
  /// [queryParameters] 请求参数
  /// [options] 请求配置
  /// [cancelToken] 取消请求的token
  Future<R> post<R, D>(String endpoint,
          {D Function(dynamic json)? fromJsonT,
          dynamic data,
          Map<String, dynamic>? queryParameters,
          Options? options,
          CancelToken? cancelToken}) =>
      _performRequest<R, D>(
          () => _dio.post(endpoint,
              data: data is Map<String, dynamic> ? data : data?.toJson(),
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken),
          fromJsonT);
}
