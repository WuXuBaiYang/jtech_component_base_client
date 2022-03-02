import 'package:jtech_component_library/jcomponent.dart';
import 'package:flutter/material.dart';

void main() {
  runMaterialAPP(
    title: "jtech base library",
    welcomePage: WelcomePage(),
    homePage: MyHomePage(),
    routes: {},
  );
}

/*
* 主页面
* @author jtechjh
* @Time 2021/8/31 5:28 下午
*/
class MyHomePage extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "example_base",
      appBarLeadingType: AppBarLeading.none,
      body: EmptyBox(),
    );
  }
}

/*
* 欢迎页面
* @author jtechjh
* @Time 2021/8/31 5:28 下午
*/
class WelcomePage extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      showAppbar: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(),
            SizedBox(height: 15),
            Text("测试demo用例"),
          ],
        ),
      ),
    );
  }
}
