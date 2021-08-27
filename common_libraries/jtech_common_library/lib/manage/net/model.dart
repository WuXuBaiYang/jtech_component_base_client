import 'package:dio/dio.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 请求对象
* @author jtechjh
* @Time 2021/8/25 3:57 下午
*/
class RequestModel extends BaseModel {
  //查询参数
  final Map<String, dynamic>? _queryParameters;

  //消息体
  final dynamic _data;

  //头部参数
  final Map<String, dynamic>? _headers;

  Map<String, dynamic>? get queryParameters => _queryParameters;

  dynamic get data => _data;

  Map<String, dynamic>? get headers => _headers;

  RequestModel.fromForm({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  })  : this._queryParameters = queryParameters,
        this._headers = headers,

        ///
        this._data = FormData.fromMap({});
}

/*
* 接口请求form表单对象构造
* @author jtechjh
* @Time 2021/8/25 5:17 下午
*/
class RequestForm {}

//请求响应业务逻辑判断回调
typedef OnResponseSuccess = bool Function(int code, String message);

/*
* 请求响应对象
* @author jtechjh
* @Time 2021/8/25 3:55 下午
*/
class ResponseModel<T> extends BaseModel {
  //状态码
  final int statusCode;

  //状态描述
  final String statusMessage;

  //响应状态码
  final int code;

  //响应描述
  final String message;

  //返回值
  final T data;

  //判断响应状态是否成功的回调
  final OnResponseSuccess _responseSuccess;

  //判断网络请求是否成功
  bool get httpSuccess => statusCode == 200 || statusCode == 201;

  //判断接口请求是否成功(需使用者自行实现)
  bool get requestSuccess => _responseSuccess(code, message);

  //判断整体请求是否成功(网络+接口业务全成功)
  bool get success => httpSuccess && requestSuccess;

  //获取响应消息
  String get responseMessage {
    List<String> list = [];
    if (statusMessage.isNotEmpty) list.add(statusMessage);
    if (message.isNotEmpty) list.add(message);
    return list.join(";");
  }

  //构建响应对象
  ResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.code,
    required this.message,
    required this.data,
    required OnResponseSuccess responseSuccess,
  }) : this._responseSuccess = responseSuccess;
}
