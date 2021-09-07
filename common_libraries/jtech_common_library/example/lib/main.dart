import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:flutter/material.dart';

import 'audio/audio_demo.dart';
import 'avatar/avatar_demo.dart';
import 'banner/banner_demo.dart';
import 'button/button_demo.dart';
import 'camera/camera_demo.dart';
import 'card/card_demo.dart';
import 'form/form_demo.dart';
import 'gridview/accessory_gridview_demo.dart';
import 'gridview/default_gridview_demo.dart';
import 'gridview/gridview_demo.dart';
import 'gridview/refresh_gridview_demo.dart';
import 'image/image_demo.dart';
import 'listview/default_listview_demo.dart';
import 'listview/index_listview_demo.dart';
import 'listview/listview_demo.dart';
import 'listview/refresh_listview_demo.dart';
import 'manage/manage_demo.dart';
import 'navigation/bottom_navigation_demo.dart';
import 'navigation/navigation_demo.dart';
import 'navigation/tablayout_demo.dart';
import 'picker/picker_demo.dart';
import 'popups/popups_demo.dart';
import 'tools/tools_page.dart';
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
      "/test/gridview/accessory": (_) => AccessoryGridviewDemo(),
      "/test/form_demo": (_) => FormDemo(),
      "/test/tools_demo": (_) => ToolsDemo(),
      "/test/camera": (_) => CameraDemo(),
      "/test/video_player_demo": (_) => VideoPlayerDemo(),
      "/test/audio_demo": (_) => AudioDemo(),
      "/test/file_picker": (_) => FilePickerDemo(),
      "/test/manage_demo": (_) => ManageDemo(),
      "/test/avatar_demo": (_) => AvatarDemo(),
    },
    welcomePage: WelcomePage(),
    homePage: MyHomePage(),
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
    "头像组件": "/test/avatar_demo",
    "管理工具": "/test/manage_demo",
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info_outline_rounded),
        onPressed: () {
          jRouter.push(ImageEditorPagePage(ImageDataSource.net(
            "https://th.bing.com/th/id/OIP.M2dHJdmuNPhuODWuMLIK_gHaEo?w=296&h=184&c=7&r=0&o=5&dpr=2&pid=1.7",
            cacheRawData: true,
          )));
        },
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
