import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/widgets/root_app/config.dart';

/*
* material样式的app根节点组件
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
class MaterialRootAPP extends BaseStatelessWidget {
  //启动首页
  final Widget homePage;

  //配置信息
  final MaterialAppConfig config;

  MaterialRootAPP({
    required String title,
    required this.homePage,
    required Map<String, WidgetBuilder> routes,
    MaterialAppConfig? config,
  }) : this.config = (config ?? MaterialAppConfig()).copyWith(
          title: title,
          routes: routes,
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.title,
      navigatorKey: jBase.router.navigateKey,
      theme: config.theme,
      locale: config.locale,
      localizationsDelegates: config.localizationsDelegates,
      supportedLocales: config.supportedLocales,
      routes: config.routes,
      home: homePage,
    );
  }
}
