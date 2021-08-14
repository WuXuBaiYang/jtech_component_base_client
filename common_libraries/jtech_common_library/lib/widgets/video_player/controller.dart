import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:jtech_common_library/base/base_controller.dart';
import 'package:video_player/video_player.dart';

/*
* 视频播放器控制器
* @author jtechjh
* @Time 2021/8/4 10:36 上午
*/
class JVideoPlayerController extends BaseController {
  //播放器控制器
  final ChewieController _videoController;

  //获取视频控制器
  ChewieController get videoController => _videoController;

  //asset资源
  JVideoPlayerController.asset({
    required String dataSource,
    String? package,
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? showControls,
    bool? allowedScreenSleep,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
  }) : this._videoController = _createController(
          controller: VideoPlayerController.asset(
            dataSource,
            package: package,
          ),
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        );

  //网络资源
  JVideoPlayerController.net({
    required String dataSource,
    Map<String, String> httpHeaders = const {},
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? showControls,
    bool? allowedScreenSleep,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
  }) : this._videoController = _createController(
          controller: VideoPlayerController.network(
            dataSource,
            httpHeaders: httpHeaders,
          ),
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        );

  //本地资源
  JVideoPlayerController.file({
    required File file,
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? showControls,
    bool? allowedScreenSleep,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
  }) : this._videoController = _createController(
          controller: VideoPlayerController.file(file),
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        );

  //创建控制器
  static ChewieController _createController({
    required VideoPlayerController controller,
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? showControls,
    bool? showControlsOnInitialize,
    bool? autoInitialize,
    bool? fullScreenByDefault,
    bool? allowedScreenSleep,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
    bool? showOptions,
  }) =>
      ChewieController(
        videoPlayerController: controller,
        autoPlay: autoPlay ?? false,
        autoInitialize: autoInitialize ?? false,
        startAt: startAt,
        looping: looping ?? false,
        fullScreenByDefault: fullScreenByDefault ?? false,
        showControls: showControls ?? true,
        showControlsOnInitialize: showControlsOnInitialize ?? true,
        allowedScreenSleep: allowedScreenSleep ?? true,
        allowFullScreen: allowFullScreen ?? true,
        allowMuting: allowMuting ?? true,
        allowPlaybackSpeedChanging: allowPlaybackSpeedChanging ?? true,
        showOptions: showOptions ?? false,
      );

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    _videoController..videoPlayerController.dispose()..dispose();
  }
}
