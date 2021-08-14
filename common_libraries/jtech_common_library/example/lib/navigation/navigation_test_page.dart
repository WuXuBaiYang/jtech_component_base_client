import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 导航测试页面
* @author wuxubaiyang
* @Time 2021/7/12 下午1:24
*/
class NavigationTestPage extends BaseStatelessPage {
  final String text;
  final Color color;

  NavigationTestPage({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
