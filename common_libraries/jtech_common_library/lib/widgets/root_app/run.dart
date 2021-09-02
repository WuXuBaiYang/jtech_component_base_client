import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/popups/popups.dart';

//初始化方法
typedef OnWelcomeInitial = Future<void> Function();
/*
* 启动material样式的app根节点
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
void runMaterialAPP({
  required String title,
  required Widget homePage,
  required Map<String, WidgetBuilder> routes,
  Widget? welcomePage,
  OnWelcomeInitial? welcomeInitial,
  Duration welcomeDuration = const Duration(milliseconds: 1500),
  ThemeData? theme,
  Locale? locale,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Iterable<Locale>? supportedLocales,
}) {
  _loadInitial(welcomeInitial, welcomeDuration, homePage);
  runApp(MaterialAPPRoot(
    title: title,
    routes: routes,
    theme: theme,
    locale: locale,
    navigatorKey: jRouter.navigateKey,
    localizationsDelegates: localizationsDelegates,
    supportedLocales: supportedLocales,
    homePage: welcomePage ?? homePage,
  ));
}

//加载初始化方法
Future<void> _loadInitial(
  OnWelcomeInitial? welcomeInitial,
  Duration welcomeDuration,
  Widget homePage,
) async {
  //执行用户设置的初始化方法并记录时间戳
  DateTime startTime = DateTime.now();
  //遍历初始化默认方法
  for (var item in _defInit) await item();
  await welcomeInitial?.call();
  DateTime endTime = DateTime.now();
  //计算差值，有剩余时间则等待
  var diff = endTime.difference(startTime);
  diff = welcomeDuration.subtract(diff);
  if (diff.greaterThan(Duration.zero)) {
    await Future.delayed(diff);
  }
  //跳转到首页
  return jRouter.pushReplacement(homePage);
}

//默认初始化方法
final List<Function> _defInit = [
  jToast.init,
  jManage.init,
  jPopups.init,
];
