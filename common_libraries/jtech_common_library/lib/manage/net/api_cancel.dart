import 'package:dio/dio.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 请求撤销管理
* @author jtechjh
* @Time 2021/8/27 11:09 上午
*/
class JAPICancelManage extends BaseManage {
  static final JAPICancelManage _instance = JAPICancelManage._internal();

  factory JAPICancelManage() => _instance;

  JAPICancelManage._internal();

  //缓存接口取消key
  final Map<String, JCancelToken> _cancelKeyMap = {};

  @override
  Future<void> init() async {}

  //生成一个取消授权并返回
  JCancelToken generateToken(String key) {
    if (null != _cancelKeyMap[key]) {
      return _cancelKeyMap[key]!;
    }
    var cancelToken = JCancelToken();
    _cancelKeyMap[key] = cancelToken;
    return cancelToken;
  }

  //判断请求是否已取消
  bool isRequestCanceled(String key) => _cancelKeyMap[key]?.isCancelled ?? true;

  //移除并取消请求
  void cancelRequest(String key, {String? reason}) =>
      _cancelKeyMap.remove(key)?.cancel(reason);

  //取消所有请求
  void cancelAllRequest({String? reason}) =>
      _cancelKeyMap.removeWhere((key, value) {
        value.cancel(reason);
        return true;
      });
}

//单例调用
final jAPICancel = JAPICancelManage();

/*
* 请求撤销token
* @author jtechjh
* @Time 2021/8/27 11:19 上午
*/
class JCancelToken extends CancelToken {}
