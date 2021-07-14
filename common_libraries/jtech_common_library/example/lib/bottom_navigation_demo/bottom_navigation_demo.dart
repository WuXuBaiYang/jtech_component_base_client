import 'package:example/bottom_navigation_demo/navigation_page_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/navigation/bottom_navigation.dart';
import 'package:jtech_common_library/widgets/navigation/controller.dart';
import 'package:jtech_common_library/widgets/navigation/item.dart';

import 'navigation_page_2.dart';
import 'navigation_page_3.dart';

/*
* 底部导航demo
* @author wuxubaiyang
* @Time 2021/7/12 上午11:32
*/
class BottomNavigationDemo extends BasePage {
  //底部导航控制器
  final JBottomNavigationController controller = JBottomNavigationController(
    initialIndex: 1,
    items: [
      NormalNavigationItem(
        page: NavigationPageDemo1(),
        title: "页面1",
        titleColor: Colors.black,
        activeTitleColor: Colors.red,
        activeFontSize: 18,
        // title: Text("页面1"),
        image: Icon(Icons.home),
        activeImage: Icon(
          Icons.home,
          color: Colors.red,
        ),
      ),
      NavigationItem(
        page: NavigationPageDemo2(),
        title: Text("页面2"),
        image: Icon(Icons.badge),
        activeImage: Icon(
          Icons.badge,
          color: Colors.blue,
        ),
      ),
      NormalNavigationItem(
        page: NavigationPageDemo3(),
        title: "页面3",
        titleColor: Colors.black,
        activeTitleColor: Colors.green,
        activeFontSize: 18,
        // title: Text("页面3"),
        image: Icon(Icons.build),
        activeImage: Icon(
          Icons.build,
          color: Colors.green,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("底部导航demo"),
        actions: [
          IconButton(
            icon: Text("角标"),
            onPressed: () {
              controller.addBadge(
                2,
                JBadgeView(
                  text: "99+",
                ),
              );
            },
          ),
          IconButton(
            icon: Text("跳转最后一页"),
            onPressed: () {
              controller.select(2);
            },
          ),
        ],
      ),
      body: JBottomNavigation(
        canScroll: true,
        controller: controller,
      ),
    );
  }
}