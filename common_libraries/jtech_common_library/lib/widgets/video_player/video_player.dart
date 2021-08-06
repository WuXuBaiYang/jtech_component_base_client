import 'dart:io';
import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/video_player/config.dart';
import 'package:jtech_common_library/widgets/video_player/controller.dart';
import 'package:video_player/video_player.dart';

/*
* 视频播放器组件
* @author jtechjh
* @Time 2021/8/4 10:12 上午
*/
class JVideoPlayer extends BaseStatefulWidget {
  //控制器
  final JVideoPlayerController controller;

  //配置文件
  final VideoPlayerConfig config;

  JVideoPlayer({
    required this.controller,
    Color? backgroundColor,
    bool? autoSize,
    Size? size,
    VideoPlayerConfig? config,
  }) : this.config = (config ?? VideoPlayerConfig()).copyWith(
          backgroundColor: backgroundColor,
          autoSize: autoSize,
          size: size,
        );

  //加载本地视频
  JVideoPlayer.file({
    required File file,
    bool? autoPlay,
    Duration? startAt,
    bool? looping,
    bool? showControls,
    bool? allowedScreenSleep,
    bool? allowFullScreen,
    bool? allowMuting,
    bool? allowPlaybackSpeedChanging,
    Color? backgroundColor,
    bool? autoSize,
    Size? size,
    VideoPlayerConfig? config,
  })  : this.controller = JVideoPlayerController.file(
          file: file,
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        ),
        this.config = (config ?? VideoPlayerConfig()).copyWith(
          backgroundColor: backgroundColor,
          autoSize: autoSize,
          size: size,
        );

  //加载网络视频
  JVideoPlayer.net({
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
    Color? backgroundColor,
    bool? autoSize,
    Size? size,
    VideoPlayerConfig? config,
  })  : this.controller = JVideoPlayerController.net(
          dataSource: dataSource,
          httpHeaders: httpHeaders,
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        ),
        this.config = (config ?? VideoPlayerConfig()).copyWith(
          backgroundColor: backgroundColor,
          autoSize: autoSize,
          size: size,
        );

  //加载asset视频
  JVideoPlayer.asset({
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
    Color? backgroundColor,
    bool? autoSize,
    Size? size,
    VideoPlayerConfig? config,
  })  : this.controller = JVideoPlayerController.asset(
          dataSource: dataSource,
          package: package,
          autoPlay: autoPlay,
          startAt: startAt,
          looping: looping,
          showControls: showControls,
          allowedScreenSleep: allowedScreenSleep,
          allowFullScreen: allowFullScreen,
          allowMuting: allowMuting,
          allowPlaybackSpeedChanging: allowPlaybackSpeedChanging,
        ),
        this.config = (config ?? VideoPlayerConfig()).copyWith(
          backgroundColor: backgroundColor,
          autoSize: autoSize,
          size: size,
        );

  @override
  void initState() {
    super.initState();
    //初始化视频资源
    controller.videoController.videoPlayerController
        .initialize()
        .whenComplete(() => refreshUI());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: config.size,
      child: Container(
        color: config.backgroundColor,
        alignment: config.align,
        child: Builder(
          builder: (context) {
            if (!videoValue.isInitialized) {
              return config.initialBuilder?.call(context) ??
                  _buildDefaultInitial();
            }
            return SizedBox.fromSize(
              size: _getVideoSize(context, videoValue.size),
              child: Chewie(
                controller: controller.videoController,
              ),
            );
          },
        ),
      ),
    );
  }

  //获取当前视频播放器参数
  VideoPlayerValue get videoValue =>
      controller.videoController.videoPlayerController.value;

  //计算视频实际展示尺寸
  Size _getVideoSize(BuildContext context, Size videoSize) {
    var limitSize = config.size ?? MediaQuery.of(context).size;
    var wRatio = limitSize.width / videoSize.width;
    var hRatio = limitSize.height / videoSize.height;
    var ratio = min(wRatio, hRatio);
    return Size(
      ratio == wRatio ? limitSize.width : videoSize.width * ratio,
      ratio == hRatio ? limitSize.height : videoSize.height * ratio,
    );
  }

  //默认加载构造器
  Widget _buildDefaultInitial() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    controller.dispose();
  }
}
