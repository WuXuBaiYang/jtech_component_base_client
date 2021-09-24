import 'package:jtech_common_library/jcommon.dart';
import '../jcomponent.dart';

/*
* 授权方法入口
* @author wuxubaiyang
* @Time 2021/9/24 16:40
*/
class JAuthManage extends BaseManage {
  //缓存当前授权对象表
  Map<String, AuthModel> authMap = {};

  @override
  Future<void> init() async {
  }
}

//单例调用
final jAuth = JAuthManage();
