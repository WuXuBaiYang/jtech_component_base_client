import 'package:example/banner/banner_demo.dart';
import 'package:example/bottom_navigation_demo/bottom_navigation_demo.dart';
import 'package:example/card/card_demo.dart';
import 'package:example/form/form_demo.dart';
import 'package:example/gridview/gridview_demo.dart';
import 'package:example/image/image_demo.dart';
import 'package:example/listview_demo/index_listview_demo.dart';
import 'package:example/listview_demo/listview_demo.dart';
import 'package:example/listview_demo/refresh_listview_demo.dart';
import 'package:example/popups/popups_demo.dart';
import 'package:example/tablayout_demo/tablayout_demo.dart';
import 'package:example/tools/tools_page.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/root_app/run.dart';
import 'gridview/gridview_refresh_demo.dart';

void main() {
  runMaterialRootAPP(
    title: "jtech common library",
    routes: {
      "/test/listview": (_) => ListViewDemo(),
      "/test/refresh_listview": (_) => RefreshListViewDemo(),
      "/test/index_listview": (_) => IndexListViewDemo(),
      "/test/popups": (_) => PopupsDemo(),
      "/test/bottom_navigation": (_) => BottomNavigationDemo(),
      "/test/tab_layout": (_) => TabLayoutDemo(),
      "/test/image": (_) => ImageDemo(),
      "/test/banner": (_) => BannerDemo(),
      "/test/card": (_) => CardDemo(),
      "/test/gridview": (_) => GridviewDemo(),
      "/test/gridview_refresh": (_) => GridviewRefreshDemo(),
      "/test/form_demo": (_) => FormDemo(),
      "/test/tools_demo": (_) => ToolsDemo(),
    },
    homePage: MyHomePage(),
  );
}

class MyHomePage extends BasePage {
  //demo测试页面
  final Map<String, String> pages = {
    "基本列表组件": "/test/listview",
    "刷新列表组件": "/test/refresh_listview",
    "索引列表组件": "/test/index_listview",
    "弹窗系统事件": "/test/popups",
    "底部导航组件": "/test/bottom_navigation",
    "顶部tab导航组件": "/test/tab_layout",
    "图片组件demo": "/test/image",
    "banner demo": "/test/banner",
    "卡片视图组件": "/test/card",
    "基本表格组件": "/test/gridview",
    "刷新表格组件": "/test/gridview_refresh",
    "form表单组件": "/test/form_demo",
    "工具方法demo": "/test/tools_demo",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "example_common",
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(),
        itemCount: pages.length,
        itemBuilder: (_, index) {
          String title = pages.keys.elementAt(index);
          return ListTile(
            title: Text(title),
            onTap: () => jBase.router.push(pages[title]!),
          );
        },
      ),
    );
  }
}
