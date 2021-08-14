import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 导航测试页面
* @author wuxubaiyang
* @Time 2021/7/12 下午1:24
*/
class NavigationPageDemo1 extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        "页面1",
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NavigationPageDemo2 extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      alignment: Alignment.center,
      child: Text(
        "页面2",
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NavigationPageDemo3 extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        "页面3",
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
