import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* material样式的根节点构造配置
* @author wuxubaiyang
* @Time 2021/7/21 上午11:13
*/
class MaterialAppConfig {
  //应用标题
  String title;

  //全局样式
  ThemeData theme;

  //当前地区
  Locale locale;

  //国际化支持
  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  //支持的国家地区
  Iterable<Locale> supportedLocales;

  //路由方法集合
  Map<String, WidgetBuilder> routes;

  MaterialAppConfig({
    String? title,
    ThemeData? theme,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    Map<String, WidgetBuilder>? routes,
  })  : this.title = title ?? "",
        this.theme = theme ?? ThemeData.light(),
        this.locale = locale ?? const Locale('zh', ''),
        this.localizationsDelegates = [
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ]..addAll(localizationsDelegates ?? []),
        this.supportedLocales = [
          const Locale('en'),
          const Locale('zh'),
        ]..addAll(supportedLocales ?? []),
        this.routes = routes ?? {};

  MaterialAppConfig copyWith({
    String? title,
    ThemeData? theme,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    Map<String, WidgetBuilder>? routes,
  }) {
    return MaterialAppConfig(
      title: title ?? this.title,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      localizationsDelegates:
          localizationsDelegates ?? this.localizationsDelegates,
      supportedLocales: supportedLocales ?? this.supportedLocales,
      routes: routes ?? this.routes,
    );
  }
}
