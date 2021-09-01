import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/manage/net/model.dart';

//单次请求的响应回调控制
typedef OnResponseHandle<T> = ResponseModel<T> Function(
    int statusCode, String statusMessage, dynamic data);

/*
* 接口方法基类
* @author jtechjh
* @Time 2021/8/25 3:58 下午
*/
abstract class BaseJAPI {
  //网路请求库
  final Dio _dio;

  BaseJAPI({
    required baseUrl,
    Duration connectTimeout = Duration.zero,
    Duration receiveTimeout = Duration.zero,
    Duration sendTimeout = Duration.zero,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    int? maxRedirects,
  }) : this._dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout.inMilliseconds,
          receiveTimeout: receiveTimeout.inMilliseconds,
          sendTimeout: sendTimeout.inMilliseconds,
          queryParameters: queryParameters,
          maxRedirects: maxRedirects,
          headers: headers,
        ));

  //基本请求方法
  Future<ResponseModel<T>> request<T>(
    String path, {
    APIMethod method = APIMethod.get,
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
  }) async {
    cancelKey ??= path;
    var statusCode = -1, statusMessage = "", data;
    try {
      var response = await _dio.request(
        path,
        queryParameters: requestModel?.queryParameters,
        data: requestModel?.data,
        options: Options(
          method: method.text,
          headers: requestModel?.headers,
        ),
        cancelToken: jAPICancel.generateToken(cancelKey),
      );
      statusCode = response.statusCode ?? 200;
      statusMessage = response.statusMessage ?? "";
      data = response.data;
    } on DioError catch (e) {
      statusCode = e.response?.statusCode ?? -1;
      statusMessage = e.response?.statusMessage ?? "${e.error}";
      data = e.response?.data;
    } catch (e) {
      statusCode = -1;
      statusMessage = "请求失败";
    }
    if (null == data) {
      return ResponseModel.empty(
        statusCode: statusCode,
        statusMessage: statusMessage,
      );
    }
    return responseHandle?.call(statusCode, statusMessage, data) ??
        handleResponse<T>(statusCode, statusMessage, data);
  }

  //http-get请求
  Future<ResponseModel<T>> get<T>(
    String path, {
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
  }) =>
      request<T>(
        path,
        method: APIMethod.get,
        requestModel: requestModel,
        cancelKey: cancelKey,
        responseHandle: responseHandle,
      );

  //http-post请求
  Future<ResponseModel<T>> post<T>(
    String path, {
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
  }) =>
      request<T>(
        path,
        method: APIMethod.post,
        requestModel: requestModel,
        cancelKey: cancelKey,
        responseHandle: responseHandle,
      );

  //http-put请求
  Future<ResponseModel<T>> put<T>(
    String path, {
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
  }) =>
      request<T>(
        path,
        method: APIMethod.put,
        requestModel: requestModel,
        cancelKey: cancelKey,
        responseHandle: responseHandle,
      );

  //http-delete请求
  Future<ResponseModel<T>> delete<T>(
    String path, {
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
  }) =>
      request<T>(
        path,
        method: APIMethod.delete,
        requestModel: requestModel,
        cancelKey: cancelKey,
        responseHandle: responseHandle,
      );

  //取消请求
  void cancel(String key) => jAPICancel.cancelRequest(key);

  //处理请求响应
  ResponseModel<T> handleResponse<T>(
      int statusCode, String statusMessage, dynamic result);
}

/*
* 请求方法枚举
* @author jtechjh
* @Time 2021/8/25 4:55 下午
*/
enum APIMethod {
  get,
  post,
  put,
  delete,
}

/*
* 扩展接口请求枚举
* @author jtechjh
* @Time 2021/8/25 4:56 下午
*/
extension APIMethodExtension on APIMethod {
  //获取方法文本
  String get text {
    switch (this) {
      case APIMethod.get:
        return "GET";
      case APIMethod.post:
        return "POST";
      case APIMethod.put:
        return "PUT";
      case APIMethod.delete:
        return "DELETE";
    }
  }
}
