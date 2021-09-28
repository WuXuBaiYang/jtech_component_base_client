import 'package:flutter/widgets.dart';
import 'package:jtech_component_library/auth/view/base/config.dart';
import 'package:jtech_component_library/jcomponent.dart';

/*
* 授权组件
* @author wuxubaiyang
* @Time 2021/9/28 10:38
*/
class JAuth<T extends JListViewController> extends BaseStatefulWidgetMultiply {
  //控制器
  final T controller;

  //授权基本配置
  final AuthConfig config;

  JAuth({
    required State<JAuth> currentState,
    required this.controller,
    required this.config,
  }) : super(currentState: currentState);
}

/*
* 授权组件基类
* @author wuxubaiyang
* @Time 2021/9/28 10:44
*/
abstract class BaseJAuthState extends BaseState<JAuth> {}
