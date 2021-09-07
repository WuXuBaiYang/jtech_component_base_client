library common_library;

import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/tools/tools.dart';
import 'popups/popups.dart';

//导出基础依赖
export 'package:jtech_base_library/jbase.dart';

//导出基本方法
export 'base/base_config.dart';
export 'base/base_controller.dart';
export 'base/change_notifier.dart';
export 'base/refresh_config.dart';
export 'base/base_menu.dart';
export 'package:path/path.dart';
export 'package:http_parser/http_parser.dart';

//导出弹层方法
export 'popups/dialog/config.dart';
export 'popups/dialog/dialog.dart';
export 'popups/sheet/config.dart';
export 'popups/sheet/sheet.dart';
export 'popups/snack/config.dart';
export 'popups/snack/snack.dart';
export 'popups/toast/config.dart';
export 'popups/toast/toast.dart';
export 'popups/overlay/config.dart';
export 'popups/overlay/overlay.dart';

//管理工具
export 'manage/net/api_cancel.dart';
export 'manage/net/base_api.dart';
export 'manage/net/model.dart';
export 'manage/cache/cache.dart';
export 'manage/manage.dart';
export 'manage/notification/notification.dart';
export 'manage/notification/config.dart';

//导出工具方法
export 'tools/data_format.dart';
export 'tools/duration_format.dart';
export 'tools/file.dart';
export 'tools/matches.dart';
export 'tools/timer.dart';
export 'tools/tools.dart';
export 'tools/file_picker/file_info.dart';
export 'tools/file_picker/pages/camera_page.dart';
export 'tools/file_picker/pages/record_video_page.dart';
export 'tools/file_picker/pages/take_photo_page.dart';
export 'tools/file_picker/pages/image_editor_page.dart';
export 'tools/file_picker/config.dart';
export 'tools/file_picker/picker.dart';
export 'tools/file_picker/process/process.dart';
export 'tools/file_picker/process/image/compress.dart';
export 'tools/file_picker/process/image/crop.dart';
export 'tools/file_picker/process/image/image.dart';
export 'tools/file_picker/process/video/compress.dart';
export 'tools/file_picker/process/video/video.dart';
export 'tools/file_picker/process/audio/audio.dart';
export 'tools/permission/config.dart';
export 'tools/permission/permission.dart';
export 'tools/prewview/prewview.dart';
export 'tools/prewview/config.dart';
export 'tools/prewview/preview_page.dart';

//导出组件
export 'widgets/base/empty_box.dart';
export 'widgets/base/required.dart';
export 'widgets/app_page/material_page/material_page.dart';
export 'widgets/audio/audio_player/base/config.dart';
export 'widgets/audio/audio_player/base/controller.dart';
export 'widgets/audio/audio_player/base/audio_player.dart';
export 'widgets/audio/audio_record/base/controller.dart';
export 'widgets/audio/audio_record/base/audio_record.dart';
export 'widgets/audio/audio_record/base/config.dart';
export 'widgets/audio/audio_record/full/audio_record_full.dart';
export 'widgets/audio/audio_record/full/config.dart';
export 'widgets/audio/audio_record/audio_record_simple.dart';
export 'widgets/audio/audio_player/full/config.dart';
export 'widgets/audio/audio_player/full/audio_player_full.dart';
export 'widgets/audio/audio_player/audio_player_simple.dart';
export 'widgets/audio/base/config.dart';
export 'widgets/audio/base/controller.dart';
export 'widgets/avatar/avatar.dart';
export 'widgets/avatar/controller.dart';
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
export 'widgets/form/items/select/form_select_item.dart';
export 'widgets/form/items/select/config.dart';
export 'widgets/gridview/base/controller.dart';
export 'widgets/gridview/base/gridview.dart';
export 'widgets/gridview/base/staggered.dart';
export 'widgets/gridview/base/config.dart';
export 'widgets/gridview/refresh/controller.dart';
export 'widgets/gridview/refresh/gridview_refresh.dart';
export 'widgets/gridview/gridview_default.dart';
export 'widgets/gridview/accessory/controller.dart';
export 'widgets/gridview/accessory/gridview_accessory.dart';
export 'widgets/image/clip.dart';
export 'widgets/image/config.dart';
export 'widgets/image/image.dart';
export 'widgets/image/controller.dart';
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
export 'widgets/navigation/base/navigation.dart';
export 'widgets/navigation/base/pageview/pageview.dart';
export 'widgets/listview/base/controller.dart';
export 'widgets/listview/base/listView.dart';
export 'widgets/listview/index/config.dart';
export 'widgets/listview/index/controller.dart';
export 'widgets/listview/index/listview_index.dart';
export 'widgets/listview/index/model.dart';
export 'widgets/listview/refresh/controller.dart';
export 'widgets/listview/refresh/listview_refresh.dart';
export 'widgets/listview/listview_default.dart';
export 'widgets/listview/listview_default.dart';
export 'widgets/listview/base/config.dart';
export 'widgets/listview/base/listView.dart';
export 'widgets/popup_button/popup_button.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
