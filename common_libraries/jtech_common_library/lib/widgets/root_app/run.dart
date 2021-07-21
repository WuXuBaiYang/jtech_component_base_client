import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/root_app/material_app.dart';

/*
* 启动material样式的app根节点
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
void runMaterialRootAPP({
  Function? initial,
  required Widget child,
}) {
  //执行初始化方法
  initial?.call();
  //启动应用
  runApp(child);
}
