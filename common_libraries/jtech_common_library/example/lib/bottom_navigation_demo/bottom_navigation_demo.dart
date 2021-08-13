import 'package:example/bottom_navigation_demo/navigation_page_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/app_page/navigation_page/controller.dart';
import 'package:jtech_common_library/widgets/app_page/navigation_page/bottom_navigation.dart';
import 'package:jtech_common_library/widgets/badge/config.dart';
import 'package:jtech_common_library/widgets/navigation/base/config.dart';

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
      NavigationItem.text(
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
      NavigationItem(
        page: NavigationPageDemo2(),
        title: Text("页面3"),
        image: Icon(Icons.badge),
        activeImage: Icon(
          Icons.badge,
          color: Colors.blue,
        ),
      ),
      NavigationItem.text(
        page: NavigationPageDemo3(),
        title: "页面4",
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
    return BottomNavigationPage(
      controller: controller,
      appBarTitle: "底部导航demo",
      appBarActions: [
        IconButton(
          icon: Text("角标"),
          onPressed: () {
            controller.addBadge(
              1,
              BadgeConfig(
                text: "99+",
                // size: 15,
                // elevation: 0,
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
        IconButton(
          icon: Text("snack"),
          onPressed: () {
            jCommon.popups.snack.showSnackInTime(context, text: "弹出snack测试");
          },
        ),
      ],
      notchLocation: NotchLocation.center,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.home),
      ),
    );
  }
}
