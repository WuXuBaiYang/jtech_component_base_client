import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* material样式的app根节点组件
* @author wuxubaiyang
* @Time 2021/7/21 上午10:58
*/
class MaterialRootAPP extends StatelessWidget {
  //启动首页
  final Widget homePage;

  MaterialRootAPP({
    required this.homePage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: jBase.router.navigateKey,
      home: homePage,
    );
  }
}
