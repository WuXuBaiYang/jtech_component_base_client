import 'dart:io';

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
  //播放器配置
  final VideoPlayerConfig config;

  //播放器控制器
  final VideoPlayerController playerController;

  //控制器
  final JVideoPlayerController controller;

  //创建本地文件资源的播放器
  JVideoPlayer.file({
    required File file,
    PlayerMode? mode,
    VideoPlayerConfig? config,
    JVideoPlayerController? controller,
  })  : this.playerController = VideoPlayerController.file(file),
        this.controller = controller ?? JVideoPlayerController(),
        this.config = (config ?? VideoPlayerConfig()).copyWith(
          dataSource: file.absolute.path,
          sourceType: SourceType.file,
          mode: mode,
        );

  @override
  void initState() {
    super.initState();
    //初始化控制器
    playerController.initialize().then((value) async {
      refreshUI();
      if (config.autoPlay) {
        await playerController.play();
        controller.updateState(PlayerState.playing);
      } else {
        controller.updateState(PlayerState.pause);
      }
    }).catchError((e) {
      controller.updateState(PlayerState.error);
    });
    //监听播放器状态
    playerController.addListener(() {
      var value = playerController.value;
      var state = PlayerState.none;
      if (value.isPlaying) state = PlayerState.playing;
      if (!value.isPlaying) state = PlayerState.pause;
      if (value.isBuffering) state = PlayerState.buffering;
      if (value.hasError) state = PlayerState.error;
      controller.updateState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!playerController.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return _buildPlayer();
  }

  //构建播放器组件
  Widget _buildPlayer() {
    var playerValue = playerController.value;
    return SizedBox.fromSize(
      size: config.size ?? playerValue.size,
      child: Container(
        color: config.color,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: playerValue.aspectRatio,
              child: VideoPlayer(playerController),
            ),
            Positioned.fill(child: _buildOptions()),
          ],
        ),
      ),
    );
  }

  //构建操作面板
  Widget _buildOptions() {
    return ValueListenableBuilder<PlayerState>(
      valueListenable: controller.playerListenable,
      builder: (context, value, child) {
        return InkWell(
          child: Stack(
            children: [
              Visibility(
                visible: value.isPause,
                child: Center(
                  child: config.playButton ??
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: Colors.white,
                        size: 80,
                      ),
                ),
              ),
            ],
          ),
          onTap: () async {
            if (playerController.value.isPlaying) {
              await playerController.pause();
              controller.updateState(PlayerState.pause);
            } else {
              await playerController.play();
              controller.updateState(PlayerState.playing);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁播放器
    controller.dispose();
  }
}
