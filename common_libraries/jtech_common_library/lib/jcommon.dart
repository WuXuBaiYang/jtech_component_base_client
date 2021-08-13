library common_library;

import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/tools/tools.dart';
import 'popups/popups.dart';

//导出基本方法
export 'base/base_config.dart';
export 'base/base_controller.dart';
export 'base/change_notifier.dart';
export 'base/refresh_config.dart';

//导出弹层方法
export 'popups/dialog/config.dart';
export 'popups/dialog/dialog.dart';
export 'popups/sheet/config.dart';
export 'popups/sheet/sheet.dart';
export 'popups/snack/config.dart';
export 'popups/snack/snack.dart';
export 'popups/toast/config.dart';
export 'popups/toast/toast.dart';

//导出工具方法
export 'tools/data_format.dart';
export 'tools/duration_format.dart';
export 'tools/file.dart';
export 'tools/matches.dart';
export 'tools/timer.dart';
export 'tools/tools.dart';

//导出组件
export 'widgets/base/empty_box.dart';
export 'widgets/base/required.dart';
export 'widgets/app_page/material_page/material_page.dart';
export 'widgets/audio_player/config.dart';
export 'widgets/audio_player/controller.dart';
export 'widgets/audio_player/audio_player.dart';
export 'widgets/audio_record/controller.dart';
export 'widgets/audio_record/audio_record.dart';
export 'widgets/avatar/avatar.dart';
export 'widgets/badge/config.dart';
export 'widgets/badge/badge.dart';
export 'widgets/badge/container.dart';
export 'widgets/banner/indicator/base_indicator.dart';
export 'widgets/banner/indicator/dot_indicator.dart';
export 'widgets/banner/config.dart';
export 'widgets/banner/controller.dart';
export 'widgets/banner/banner.dart';
export 'widgets/card/card.dart';
export 'widgets/form/controller.dart';
export 'widgets/form/form.dart';
export 'widgets/form/items/items.dart';
export 'widgets/gridview/base/controller.dart';
export 'widgets/gridview/base/gridview.dart';
export 'widgets/gridview/base/staggered.dart';
export 'widgets/gridview/base/config.dart';
export 'widgets/gridview/refresh/controller.dart';
export 'widgets/gridview/refresh/gridview_refresh.dart';
export 'widgets/image/clip.dart';
export 'widgets/image/config.dart';
export 'widgets/image/image.dart';
export 'widgets/root_app/material_app.dart';
export 'widgets/root_app/run.dart';
export 'widgets/video_player/config.dart';
export 'widgets/video_player/controller.dart';
export 'widgets/video_player/video_player.dart';
export 'widgets/navigation/base/controller.dart';
export 'widgets/navigation/base/config.dart';
export 'widgets/navigation/tab_layout/config.dart';
export 'widgets/navigation/tab_layout/controller.dart';
export 'widgets/navigation/tab_layout/tab_layout.dart';
export 'widgets/navigation/bottom_navigation/controller.dart';
export 'widgets/navigation/bottom_navigation/bottom_navigation.dart';
export 'widgets/listview/base/controller.dart';
export 'widgets/listview/base/listView.dart';
export 'widgets/listview/index/config.dart';
export 'widgets/listview/index/controller.dart';
export 'widgets/listview/index/listview_index.dart';
export 'widgets/listview/index/model.dart';
export 'widgets/listview/refresh/controller.dart';
export 'widgets/listview/refresh/listview_refresh.dart';
export 'widgets/listview/base/config.dart';
export 'widgets/listview/base/listView.dart';

/*
* 通用组件方法入口
* @author wuxubaiyang
* @Time 2021/7/2 下午4:06
*/
class JCommon extends BaseManage {
  static final JCommon _instance = JCommon._internal();

  factory JCommon() => _instance;

  JCommon._internal();

  //弹出层管理
  final popups = JPopups();

  //工具箱管理
  final tools = JTools();

  //初始化方法
  @override
  Future init() async {
    //初始化弹层方法
    await popups.init();
    //初始化工具方法
    await tools.init();
  }
}

//单例调用
final jCommon = JCommon();
