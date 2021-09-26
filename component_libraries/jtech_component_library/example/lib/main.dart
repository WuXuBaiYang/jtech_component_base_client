import 'package:example/pages/auth_demo/auth_demo.dart';
import 'package:jtech_component_library/jcomponent.dart';
import 'package:flutter/material.dart';

void main() {
  runMaterialAPP(
    title: "jtech component library",
    welcomePage: WelcomePage(),
    homePage: MyHomePage(),
    routes: {
      "/test/auth_demo": (_) => AuthDemoPage(),
    },
  );
}

/*
* 主页面
* @author jtechjh
* @Time 2021/8/31 5:28 下午
*/
class MyHomePage extends BaseStatelessPage {
  //demo测试页面
  final Map<String, String> pages = {
    "授权模块测试": "/test/auth_demo",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "example_component",
      appBarLeadingType: AppBarLeading.none,
      body: JListView.def<String>(
        controller: JListViewController(
          dataList: pages.keys.toList(),
        ),
        dividerBuilder: (_, index) => Divider(),
        itemBuilder: (context, item, index) => ListTile(
          title: Text(item),
          onTap: () => jRouter.pushNamed(pages[item]!),
        ),
      ),
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
