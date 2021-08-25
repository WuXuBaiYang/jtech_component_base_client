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
class RequestForm{
}

/*
* 请求响应对象
* @author jtechjh
* @Time 2021/8/25 3:55 下午
*/
class ResponseModel extends BaseModel {}
