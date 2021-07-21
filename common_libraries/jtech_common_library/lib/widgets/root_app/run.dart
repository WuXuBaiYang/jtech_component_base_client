import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/root_app/material_app.dart';

import 'config.dart';

/*
* 启动material样式的app根节点
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
void runMaterialRootAPP({
  Function? initial,
  required String title,
  required Widget homePage,
  required Map<String, WidgetBuilder> routes,
  MaterialAppConfig? config,
}) {
  //执行初始化方法
  initial?.call();
  //启动应用
  runApp(MaterialRootAPP(
    title: title,
    homePage: homePage,
    routes: routes,
    config: config,
  ));
}
