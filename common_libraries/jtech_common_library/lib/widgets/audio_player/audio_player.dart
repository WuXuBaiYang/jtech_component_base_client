import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/audio_player/config.dart';
import 'package:jtech_common_library/widgets/audio_player/controller.dart';
import 'package:jtech_common_library/tools/data_format.dart';

/*
* 音频播放器
* @author wuxubaiyang
* @Time 2021/8/7 1:26
*/
class JAudioPlayer extends BaseStatefulWidget {
  //播放控制器
  final JAudioPlayerController controller;

  //播放器配置对象
  final AudioPlayerConfig config;

  //音量预设集合
  final Map<String, double> volumeMap = {
    "0%": 0,
    "25%": 0.25,
    "50%": 0.5,
    "75%": 0.75,
    "100%": 1.0,
  };

  //倍速预设集合
  final Map<String, double> speedMap = {
    "0.5": 0.5,
    "1.0": 1.0,
    "2.0": 2.0,
    "3.0": 3.0,
  };

  //加载网络资源
  JAudioPlayer.net(
    String url, {
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
  })  : this.controller = controller ?? JAudioPlayerController(),
        this.config = (config ?? AudioPlayerConfig()).copyWith(
          dataSource: DataSource.net(url),
          autoPlay: autoPlay,
          startAt: startAt,
          margin: margin,
          padding: padding,
          elevation: elevation,
        );

  //本地文件
  JAudioPlayer.file(
    File file, {
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
  })  : this.controller = controller ?? JAudioPlayerController(),
        this.config = (config ?? AudioPlayerConfig()).copyWith(
          dataSource: DataSource.file(file),
          autoPlay: autoPlay,
          startAt: startAt,
          margin: margin,
          padding: padding,
          elevation: elevation,
        );

  //asset资源
  JAudioPlayer.asset(
    String assetName, {
    String? package,
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
  })  : this.controller = controller ?? JAudioPlayerController(),
        this.config = (config ?? AudioPlayerConfig()).copyWith(
          dataSource: DataSource.asset(assetName, package: package),
          autoPlay: autoPlay,
          startAt: startAt,
          margin: margin,
          padding: padding,
          elevation: elevation,
        );

  //内存资源
  JAudioPlayer.memory(
    Uint8List bytes, {
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
  })  : this.controller = controller ?? JAudioPlayerController(),
        this.config = (config ?? AudioPlayerConfig()).copyWith(
          dataSource: DataSource.memory(bytes),
          autoPlay: autoPlay,
          startAt: startAt,
          margin: margin,
          padding: padding,
          elevation: elevation,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: config.margin,
      elevation: config.elevation,
      color: config.backgroundColor,
      child: Container(
        padding: config.padding,
        child: Column(
          children: [
            _buildTitleContent(),
            _buildProgressSlider(),
            _buildPlayerOptions(),
          ],
        ),
      ),
    );
  }

  //构建标题部分容器
  Widget _buildTitleContent() {
    return Container(
      padding: config.titlePadding,
      child: Row(
        children: [
          config.title ?? EmptyBox(),
          Expanded(child: EmptyBox()),
          _buildSpeakerToggleAction(),
        ],
      ),
    );
  }

  //构建播放器进度部分
  Widget _buildProgressSlider() {
    return StreamBuilder<PlayProgress>(
      initialData: PlayProgress.zero(),
      stream: controller.onProgress,
      builder: (context, snap) {
        if (!snap.hasData) return EmptyBox();
        var max = snap.data!.duration;
        var curr = snap.data!.position;
        var ratio = snap.data!.ratio;
        var fCurr = jCommon.tools.durationFormat.formatMMSS(curr);
        var fMax = jCommon.tools.durationFormat.formatMMSS(max);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Slider(
              value: ratio,
              onChanged: (value) {
                var duration = max.multiply(value);
                controller.seekToPlay(duration);
              },
            ),
            Text(
              "$fCurr/$fMax",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  //构建播放器操作部分
  Widget _buildPlayerOptions() {
    return ValueListenableBuilder<AudioState>(
      valueListenable: controller.audioStateListenable,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(child: Row(children: [_buildSpeedAction()])),
            IconButton(
              icon: Icon(value == AudioState.playing
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded),
              iconSize: 60,
              onPressed: () async {
                if (value == AudioState.stopped) {
                  await controller.startPlay(
                    fromURI: config.dataSource?.audioURI,
                    fromDataBuffer: await config.dataSource?.audioData,
                    startAt: config.startAt,
                  );
                } else if (value == AudioState.playing) {
                  await controller.pausePlay();
                } else if (value == AudioState.pause) {
                  await controller.resumePlay();
                }
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Visibility(
                    visible: value != AudioState.stopped,
                    child: IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () => controller.stopPlay(),
                    ),
                  ),
                  Expanded(child: EmptyBox()),
                  _buildVolumeAction(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //构建听筒/扬声器切换控制按钮
  Widget _buildSpeakerToggleAction() {
    if (!config.allowSpeakerToggle) return EmptyBox();
    return ValueListenableBuilder<bool>(
      valueListenable: controller.speakerToggleListenable,
      builder: (context, value, child) {
        var iconData =
            value ? Icons.hearing_rounded : Icons.hearing_disabled_rounded;
        return IconButton(
          icon: Icon(iconData),
          onPressed: () => controller.speakerToggle(),
        );
      },
    );
  }

  //构建倍速控制按钮
  Widget _buildSpeedAction() {
    if (!config.allowSpeed) return EmptyBox();
    return ValueListenableBuilder<double>(
      valueListenable: controller.audioSpeedListenable,
      builder: (context, value, child) {
        return PopupMenuButton<double>(
          initialValue: value,
          child: Text(
            "x${value.toStringAsFixed(1)}",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onSelected: (value) => controller.setSpeed(value),
          itemBuilder: (BuildContext context) =>
              List.generate(speedMap.length, (index) {
            var key = speedMap.keys.elementAt(index);
            return PopupMenuItem(
              child: Text(key),
              value: speedMap[key],
            );
          }),
        );
      },
    );
  }

  //构建音量控制按钮
  Widget _buildVolumeAction() {
    if (!config.allowVolume) return EmptyBox();
    return ValueListenableBuilder<double>(
      valueListenable: controller.audioVolumeListenable,
      builder: (context, value, child) {
        var icon;
        if (value > 0.5) icon = Icons.volume_up_rounded;
        if (value > 0 && value <= 0.5) icon = Icons.volume_down_rounded;
        if (value <= 0) icon = Icons.volume_mute_rounded;
        return PopupMenuButton<double>(
          child: Icon(icon),
          initialValue: value,
          onSelected: (value) => controller.setVolume(value),
          itemBuilder: (BuildContext context) =>
              List.generate(volumeMap.length, (index) {
            var key = volumeMap.keys.elementAt(index);
            return PopupMenuItem(
              child: Text(key),
              value: volumeMap[key],
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    controller.dispose();
  }
}
