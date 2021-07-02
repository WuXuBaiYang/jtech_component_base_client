import 'package:flutter/widgets.dart';

/*
* 通用组件方法入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
@protected
class JCommon {
  static final JCommon _instance = JCommon._internal();

  factory JCommon() => _instance;

  JCommon._internal();

  //初始化方法
  Future init() async {}
}

//单例调用
final jCommon = JCommon();
