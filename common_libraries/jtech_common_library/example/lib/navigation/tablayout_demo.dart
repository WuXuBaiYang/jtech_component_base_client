import 'package:example/navigation/navigation_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 底部导航demo
* @author wuxubaiyang
* @Time 2021/7/12 上午11:32
*/
class TabLayoutDemo extends BaseStatelessPage {
  //底部导航控制器
  final JTabLayoutController controller =
      JTabLayoutController(initialIndex: 1, items: [
    NavigationItem.text(
      page: NavigationTestPage(
        text: '页面1',
        color: Colors.red,
      ),
      title: "页面1",
      titleColor: Colors.black,
      activeTitleColor: Colors.red,
      activeFontSize: 18,
      image: Icon(Icons.home),
      activeImage: Icon(
        Icons.home,
        color: Colors.red,
      ),
    ),
    NavigationItem(
      page: NavigationTestPage(
        text: '页面2',
        color: Colors.yellow,
      ),
      title: Text("页面2"),
      image: Icon(Icons.badge),
      activeImage: Icon(
        Icons.badge,
        color: Colors.yellow,
      ),
    ),
    NavigationItem.text(
      page: NavigationTestPage(
        text: '页面3',
        color: Colors.green,
      ),
      title: "页面3",
      titleColor: Colors.black,
      activeTitleColor: Colors.green,
      activeFontSize: 18,
      image: Icon(Icons.build),
      activeImage: Icon(
        Icons.build,
        color: Colors.green,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot.withTabLayout(
      controller: controller,
      appBarTitle: "顶部导航demo",
      appBarActions: [
        IconButton(
          icon: Text("角标"),
          onPressed: () => controller.addBadge(1, BadgeConfig(text: "99+")),
        ),
        IconButton(
          icon: Text("跳转最后一页"),
          onPressed: () => controller.select(2),
        ),
      ],
    );
  }
}
