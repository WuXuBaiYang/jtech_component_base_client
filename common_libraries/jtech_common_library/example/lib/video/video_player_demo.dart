import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/video_player/config.dart';
import 'package:jtech_common_library/widgets/video_player/controller.dart';
import 'package:jtech_common_library/widgets/video_player/video_player.dart';

/*
* 视频播放器组件
* @author jtechjh
* @Time 2021/8/6 2:57 下午
*/
class VideoPlayerDemo extends BasePage {
  //初始化控制器
  final JVideoPlayerController controller = JVideoPlayerController.net(
    dataSource:
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    autoPlay: true,
    // showControls: false,
    allowedScreenSleep: false,
    allowFullScreen: false,
    allowPlaybackSpeedChanging: false,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "视频播放器",
      body: JVideoPlayer(
        controller: controller,
        config: VideoPlayerConfig(
          align: Alignment.topCenter
        ),
      ),
    );
  }
}
