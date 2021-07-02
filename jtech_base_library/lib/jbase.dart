import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/event/jevent.dart';
import 'package:jtech_base_library/route/jrouter.dart';

/*
* 基本库方法入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
@protected
class JBase {
  static final JBase _instance = JBase._internal();

  factory JBase() => _instance;

  JBase._internal();

  //消息总线方法
  final event = JEvent();

  //路由方法
  final router = JRouter();

  //初始化方法
  Future init() async {
    //初始化消息总线
    await event.init();
    //初始化路由方法
    await router.init();
  }
}

//单例调用
final jBase = JBase();
