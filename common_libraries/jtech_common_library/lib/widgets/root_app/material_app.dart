import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* material样式的app根节点组件
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
class MaterialAPPRoot extends BaseStatelessWidget {
  //启动首页
  final Widget homePage;

  //应用标题
  final String title;

  //全局样式
  final ThemeData? theme;

  //当前地区
  final Locale? locale;

  //国际化支持
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  //支持的国家地区
  final Iterable<Locale>? supportedLocales;

  //路由方法集合
  final Map<String, WidgetBuilder> routes;

  //路由管理key
  final GlobalKey<NavigatorState>? navigatorKey;

  MaterialAPPRoot({
    required this.title,
    required this.homePage,
    required this.routes,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        navigatorKey: navigatorKey,
        theme: theme ?? ThemeData.light(),
        locale: locale ?? const Locale('zh', ''),
        localizationsDelegates: [
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ]..addAll(localizationsDelegates ?? []),
        supportedLocales: [
          const Locale('en'),
          const Locale('zh'),
        ]..addAll(supportedLocales ?? []),
        routes: routes,
        home: homePage,
      );
}
