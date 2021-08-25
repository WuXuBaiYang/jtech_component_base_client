import 'package:dio/dio.dart';
import 'package:jtech_common_library/manage/net/model.dart';

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
  Future request(
    String path, {
    APIMethod method = APIMethod.get,
    RequestModel? request,
  }) async {
    _dio.request(
      path,
      queryParameters: request?.queryParameters,
      data: request?.data,
    );
  }
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
