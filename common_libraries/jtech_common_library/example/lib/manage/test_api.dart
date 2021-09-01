import 'package:jtech_common_library/jcommon.dart';

/*
* 测试接口
* @author jtechjh
* @Time 2021/9/1 11:57 上午
*/
class TestAPI extends BaseJAPI {
  TestAPI() : super(baseUrl: "https://api.muxiaoguo.cn");

  //获取每日一句话
  Future<ResponseModel<Map<String, dynamic>>> getDailyTalk() {
    return get("/api/dujitang");
  }

  @override
  ResponseModel<T> handleResponse<T>(
      int statusCode, String statusMessage, result) {
    return ResponseModel<T>(
      statusCode: statusCode,
      statusMessage: statusMessage,
      code: result["code"],
      message: result["msg"],
      data: result["data"],
      responseSuccess: (code, msg) {
        return code == "200";
      },
    );
  }
}
