library component_library;

import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_component_library/auth/auth.dart';
import 'package:jtech_component_library/jcomponent.dart';

//导出基础依赖
export 'package:jtech_base_library/jbase.dart';
export 'package:jtech_common_library/jcommon.dart';

//导出基本方法
export 'run.dart';

//导出授权模块
export 'auth/auth.dart';
export 'auth/model.dart';
export 'auth/view/base/auth.dart';
export 'auth/view/base/config.dart';
export 'auth/view/base/controller.dart';
export 'auth/view/login/login.dart';

/*
* 基本业务组件入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
@protected
class JComponent extends BaseManage {
  static final JComponent _instance = JComponent._internal();

  factory JComponent() => _instance;

  JComponent._internal();

  //初始化方法
  @override
  Future init() async {
    //初始化授权管理
    await jAuth.init();
  }
}

//单例调用
final jComponent = JComponent();
