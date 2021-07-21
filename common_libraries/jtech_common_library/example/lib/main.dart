import 'package:example/banner/banner_demo.dart';
import 'package:example/bottom_navigation_demo/bottom_navigation_demo.dart';
import 'package:example/card/card_demo.dart';
import 'package:example/gridview/gridview_demo.dart';
import 'package:example/image/image_demo.dart';
import 'package:example/listview_demo/index_listview_demo.dart';
import 'package:example/listview_demo/listview_demo.dart';
import 'package:example/listview_demo/refresh_listview_demo.dart';
import 'package:example/popups/popups_demo.dart';
import 'package:example/tablayout_demo/tablayout_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_base_library/jbase.dart';
import 'gridview/gridview_refresh_demo.dart';

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
      locale: const Locale('zh', ''),
      home: MyHomePage(),
      localizationsDelegates: [
        // RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
      ],
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
      },
    );
  }
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
            onTap: () => jBase.router.push(pages[title]!),
          );
        },
      ),
    );
  }
}
