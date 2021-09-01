import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 请求对象
* @author jtechjh
* @Time 2021/8/25 3:57 下午
*/
class RequestModel extends BaseModel {
  //查询参数
  final Map<String, dynamic>? queryParameters;

  //消息体
  final dynamic data;

  //头部参数
  final Map<String, dynamic>? headers;

  RequestModel({
    this.queryParameters,
    this.headers,
    this.data,
  });

  //构造为query方法结构，无data
  RequestModel.query({
    required this.queryParameters,
    this.headers,
  }) : this.data = null;

  //构造为map结构的data
  RequestModel.map({
    required this.data,
    this.queryParameters,
    this.headers,
  });

  //构造为json(字符串)结构的data
  RequestModel.json({
    required String data,
    this.queryParameters,
    this.headers,
  }) : this.data = jsonDecode(data);

  //表单构建模式
  static RequestFormBuilder form({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) =>
      RequestFormBuilder(
        queryParameters: queryParameters,
        headers: headers,
        data: data,
      );
}

/*
* 接口请求form表单对象构造
* @author jtechjh
* @Time 2021/8/25 5:17 下午
*/
class RequestFormBuilder extends RequestModel {
  RequestFormBuilder({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) : super(
            queryParameters: queryParameters,
            headers: headers,
            data: FormData.fromMap(data ?? {}));

  //添加参数
  RequestFormBuilder add(String key, dynamic value) =>
      this..addAll({key: value});

  //添加多个参数
  RequestFormBuilder addAll(Map<String, dynamic> data) => this
    ..data.fields.addAll(
        data.map((key, value) => MapEntry(key, value.toString())).entries);

  //添加文件
  RequestFormBuilder addFileSync(
    String key,
    String filePath, {
    String? filename,
    MediaType? mediaType,
  }) =>
      this
        ..data.files.add(MapEntry(
              key,
              MultipartFile.fromFileSync(
                filePath,
                filename: filename,
                contentType: mediaType,
              ),
            ));

  //添加多个文件
  RequestFormBuilder addFilesSync(
    String key,
    List<RequestFileItem> files,
  ) =>
      this
        ..data.files.addAll(files
            .map((item) => MapEntry(
                key,
                MultipartFile.fromFileSync(
                  item.filePath,
                  filename: item.filename,
                  contentType: item.mediaType,
                )))
            .toList());

  //构建为请求对象
  RequestModel build() => this;
}

/*
* 接口请求文件对象
* @author jtechjh
* @Time 2021/8/27 4:56 下午
*/
class RequestFileItem {
  //文件路径
  final String filePath;

  //文件名
  final String? filename;

  //文件类型
  final MediaType? mediaType;

  RequestFileItem({
    required this.filePath,
    this.filename,
    this.mediaType,
  });
}

//请求响应业务逻辑判断回调
typedef OnResponseSuccess = bool Function(String code, String message);

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
  final String code;

  //响应描述
  final String message;

  //返回值
  final T? data;

  //判断响应状态是否成功的回调
  final OnResponseSuccess _responseSuccess;

  //判断网络请求是否成功
  bool get httpSuccess => statusCode == 200 || statusCode == 201;

  //判断接口请求是否成功(需使用者自行实现)
  bool get requestSuccess => _responseSuccess.call(code, message);

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

  //构建失败响应对象
  ResponseModel.empty({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  })  : this.code = "$statusCode",
        this.message = statusMessage,
        this._responseSuccess = _defResponseSuccess;

  //响应结果判断
  static bool _defResponseSuccess(String code, String message) =>
      code == "200" || code == "201";
}
