import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 启动material样式的app根节点
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
void runMaterialAPP({
  Function? initial,
  required String title,
  required Widget homePage,
  required Map<String, WidgetBuilder> routes,
  ThemeData? theme,
  Locale? locale,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Iterable<Locale>? supportedLocales,
}) {
  //执行初始化方法
  initial?.call();
  //启动应用
  runApp(MaterialAPPRoot(
    title: title,
    homePage: homePage,
    routes: routes,
    theme: theme,
    locale: locale,
    localizationsDelegates: localizationsDelegates,
    supportedLocales: supportedLocales,
  ));
}
