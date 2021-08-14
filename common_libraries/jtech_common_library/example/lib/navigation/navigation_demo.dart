import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 导航demo
* @author wuxubaiyang
* @Time 2021/7/12 上午11:32
*/
class NavigationDemo extends BaseStatelessPage {
  //导航demo列表
  final Map<String, String> navigationDemoMap = {
    "底部导航": "/test/navigation/bottom_navigation",
    "顶部导航": "/test/navigation/tab_layout",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "顶部导航demo",
      body: JListView.def<String>(
        itemBuilder: (_, item, index) {
          return ListTile(
            title: Text(item),
            onTap: () => jRouter.pushNamed(navigationDemoMap[item]!),
          );
        },
        controller: JListViewController(
          dataList: navigationDemoMap.keys.toList(),
        ),
      ),
    );
  }
}
