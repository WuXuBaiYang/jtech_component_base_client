import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 视频播放器组件
* @author jtechjh
* @Time 2021/8/6 2:57 下午
*/
class VideoPlayerDemo extends BaseStatelessPage {
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
    return MaterialPageRoot(
      appBarTitle: "视频播放器",
      body: JVideoPlayer(
        controller: controller,
        config: VideoPlayerConfig(
          align: Alignment.topCenter,
        ),
      ),
    );
  }
}
