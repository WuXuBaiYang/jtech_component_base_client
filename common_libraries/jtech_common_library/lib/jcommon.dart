import 'package:jtech_common_library/tools/tools.dart';

import 'popups/popups.dart';

/*
* 通用组件方法入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
class JCommon {
  static final JCommon _instance = JCommon._internal();

  factory JCommon() => _instance;

  JCommon._internal();

  //弹出层管理
  final popups = Popups();

  //工具箱管理
  final tools = Tools();

  //初始化方法
  Future init() async {
    await popups.init();
    await tools.init();
  }
}

//单例调用
final jCommon = JCommon();
