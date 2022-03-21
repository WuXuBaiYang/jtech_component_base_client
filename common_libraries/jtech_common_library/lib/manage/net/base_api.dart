import 'dart:async';
import 'package:dio/dio.dart';
import 'package:jtech_common_library/jcommon.dart';

//进度回调
typedef OnProgressCallback = void Function(int count, int total);

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
  }) : this._dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout.inMilliseconds,
      receiveTimeout: receiveTimeout.inMilliseconds,
      sendTimeout: sendTimeout.inMilliseconds,
      queryParameters: queryParameters,
      maxRedirects: maxRedirects,
      headers: headers,
    ),
  ) {
    //添加拦截器
    _dio.interceptors
      ..add(InterceptorsWrapper(
        onResponse: (res, handler) {
          //处理401授权失效异常
          if (res.statusCode == 401) {
            return onAuthFailureInterceptor(res, handler);
          }
          return handler.next(res);
        },
      ))
      ..addAll(loadInterceptors);
  }

  //加载拦截器
  List<Interceptor> get loadInterceptors => [];

  //401授权失效拦截
  void onAuthFailureInterceptor(Response e,
      ResponseInterceptorHandler handler) {
    return handler.reject(
      DioError(requestOptions: e.requestOptions),
    );
  }

  //附件下载
  Future<ResponseModel> download(String urlPath, {
    required String savePath,
    APIMethod method = APIMethod.get,
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle? responseHandle,
    OnProgressCallback? onReceiveProgress,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
  }) {
    cancelKey ??= urlPath;
    return handleRequest(
      onRequest: _dio.download(
        urlPath,
        savePath,
        queryParameters: requestModel?.queryParameters,
        data: requestModel?.data,
        options: Options(
          method: method.text,
          headers: requestModel?.headers,
        ),
        cancelToken: jAPICancel.generateToken(cancelKey),
        onReceiveProgress: onReceiveProgress,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
      ),
      responseHandle: responseHandle,
    );
  }

  //基本请求方法
  Future<ResponseModel<T>> request<T>(String path, {
    APIMethod method = APIMethod.get,
    RequestModel? requestModel,
    String? cancelKey,
    OnResponseHandle<T>? responseHandle,
    OnProgressCallback? onSendProgress,
    OnProgressCallback? onReceiveProgress,
  }) async {
    cancelKey ??= path;
    return handleRequest<T>(
      onRequest: _dio.request(
        path,
        queryParameters: requestModel?.queryParameters,
        data: requestModel?.data,
        options: Options(
          method: method.text,
          followRedirects: false,
          headers: requestModel?.headers,
        ),
        cancelToken: jAPICancel.generateToken(cancelKey),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      responseHandle: responseHandle,
    );
  }

  //处理请求响应
  Future<ResponseModel<T>> handleRequest<T>({
    required Future<Response> onRequest,
    OnResponseHandle<T>? responseHandle,
  }) async {
    var statusCode = -1,
        statusMessage = "",
        data;
    try {
      var response = await onRequest;
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
  Future<ResponseModel<T>> get<T>(String path, {
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
  Future<ResponseModel<T>> post<T>(String path, {
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
  Future<ResponseModel<T>> put<T>(String path, {
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
  Future<ResponseModel<T>> delete<T>(String path, {
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
  ResponseModel<T> handleResponse<T>(int statusCode, String statusMessage,
      dynamic result);
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
