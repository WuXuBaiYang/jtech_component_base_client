import 'package:example/picker/picker_demo.dart';
import 'package:example/popups/popups_demo.dart';
import 'package:example/tools/tools_page.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'audio/audio_demo.dart';
import 'banner/banner_demo.dart';
import 'button/button_demo.dart';
import 'camera/camera_demo.dart';
import 'card/card_demo.dart';
import 'form/form_demo.dart';
import 'gridview/default_gridview_demo.dart';
import 'gridview/gridview_demo.dart';
import 'gridview/refresh_gridview_demo.dart';
import 'image/image_demo.dart';
import 'listview/default_listview_demo.dart';
import 'listview/index_listview_demo.dart';
import 'listview/listview_demo.dart';
import 'listview/refresh_listview_demo.dart';
import 'navigation/bottom_navigation_demo.dart';
import 'navigation/navigation_demo.dart';
import 'navigation/tablayout_demo.dart';
import 'video/video_player_demo.dart';

void main() {
  runMaterialAPP(
    title: "jtech common library",
    routes: {
      "/test/button": (_) => ButtonDemo(),
      "/test/listview": (_) => ListViewDemo(),
      "/test/listview/refresh": (_) => RefreshListViewDemo(),
      "/test/listview/index": (_) => IndexListViewDemo(),
      "/test/listview/full": (_) => DefaultListViewDemo(),
      "/test/popups": (_) => PopupsDemo(),
      "/test/navigation": (_) => NavigationDemo(),
      "/test/navigation/bottom_navigation": (_) => BottomNavigationDemo(),
      "/test/navigation/tab_layout": (_) => TabLayoutDemo(),
      "/test/image": (_) => ImageDemo(),
      "/test/banner": (_) => BannerDemo(),
      "/test/card": (_) => CardDemo(),
      "/test/gridview": (_) => GridviewDemo(),
      "/test/gridview/full": (_) => DefaultGridviewDemo(),
      "/test/gridview/refresh": (_) => RefreshGridviewDemo(),
      "/test/form_demo": (_) => FormDemo(),
      "/test/tools_demo": (_) => ToolsDemo(),
      "/test/camera": (_) => CameraDemo(),
      "/test/video_player_demo": (_) => VideoPlayerDemo(),
      "/test/audio_demo": (_) => AudioDemo(),
      "/test/file_picker": (_) => FilePickerDemo(),
    },
    homePage: MyHomePage(),
  );
}

class MyHomePage extends BaseStatelessPage {
  //demo测试页面
  final Map<String, String> pages = {
    "附件选择方法": "/test/file_picker",
    "音频组件": "/test/audio_demo",
    "按钮组件": "/test/button",
    "列表组件": "/test/listview",
    "弹层组件": "/test/popups",
    "导航组件": "/test/navigation",
    "图片组件": "/test/image",
    "轮播图组件": "/test/banner",
    "卡片组件": "/test/card",
    "表格组件": "/test/gridview",
    "表单组件": "/test/form_demo",
    "工具方法": "/test/tools_demo",
    "摄像头": "/test/camera",
    "视频播放器组件": "/test/video_player_demo",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "example_common",
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
