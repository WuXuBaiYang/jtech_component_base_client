import 'package:flutter/widgets.dart';

/*
* 基本业务组件入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
@protected
class JBusiness {
  static final JBusiness _instance = JBusiness._internal();

  factory JBusiness() => _instance;

  JBusiness._internal();

  //初始化方法
  Future init() async {}
}

//单例调用
final jBusiness = JBusiness();
