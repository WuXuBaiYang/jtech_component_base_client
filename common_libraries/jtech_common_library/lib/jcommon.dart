import 'package:flutter/widgets.dart';

import 'popups/popups.dart';

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

  //弹出层管理
  final popups = Popups();

  //初始化方法
  Future init() async {
    //初始化弹出层管理方法
    await popups.init();
  }
}

//单例调用
final jCommon = JCommon();
