import 'package:example/banner/banner_demo.dart';
import 'package:example/bottom_navigation_demo/bottom_navigation_demo.dart';
import 'package:example/image/image_demo.dart';
import 'package:example/listview_demo/index_listview_demo.dart';
import 'package:example/listview_demo/listview_demo.dart';
import 'package:example/listview_demo/refresh_listview_demo.dart';
import 'package:example/popups/popups_demo.dart';
import 'package:example/tablayout_demo/tablayout_demo.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_base_library/jbase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: jBase.router.navigateKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends BasePage {
  //demo测试页面
  final Map<String, BasePage> pages = {
    "基本列表组件": ListViewDemo(),
    "刷新列表组件": RefreshListViewDemo(),
    "索引列表组件": IndexListViewDemo(),
    "弹窗系统事件": PopupsDemo(),
    "底部导航组件": BottomNavigationDemo(),
    "顶部tab导航组件": TabLayoutDemo(),
    "图片组件demo": ImageDemo(),
    "banner demo": BannerDemo(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example_common"),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(),
        itemCount: pages.length,
        itemBuilder: (_, index) {
          String title = pages.keys.elementAt(index);
          return ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return pages.values.elementAt(index);
              }));
            },
          );
        },
      ),
    );
  }
}
