import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
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

  //管理手动拖拽时的进度
  final ValueChangeNotifier<double> seekProgress = ValueChangeNotifier(-1);

  //音量控制
  final ValueChangeNotifier<double> volume = ValueChangeNotifier(0.5);

  //音量预设集合
  final Map<String, double> volumeMap = {
    "0%": 0,
    "25%": 0.25,
    "50%": 0.5,
    "75%": 0.75,
    "100%": 1.0,
  };

  //速度控制
  final ValueChangeNotifier<double> speed = ValueChangeNotifier(1.0);

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
            Container(
              alignment:
                  config.centerTitle ? Alignment.center : Alignment.centerLeft,
              child: config.title ?? EmptyBox(),
            ),
            _buildProgressSlider(),
            _buildPlayerOptions(),
          ],
        ),
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
        return ValueListenableBuilder<double>(
          valueListenable: seekProgress,
          builder: (context, value, child) {
            var isSlide = -1 != value;
            var max = snap.data!.duration;
            var curr = isSlide ? max.multiply(value) : snap.data!.position;
            var ratio = isSlide ? value : snap.data!.ratio;
            var fCurr = jCommon.tools.durationFormat.formatMMSS(curr);
            var fMax = jCommon.tools.durationFormat.formatMMSS(max);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Slider(
                  value: ratio,
                  max: max == Duration.zero ? 0.0 : 1.0,
                  onChanged: (value) => seekProgress.setValue(value),
                  onChangeEnd: (value) {
                    controller.seekToPlay(max.multiply(value));
                    seekProgress.setValue(-1.0);
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
              icon: Icon(value.isRunning
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded),
              iconSize: 60,
              onPressed: () async {
                if (!value.isWorked) {
                  await controller.startPlay(
                    fromURI: config.dataSource?.audioURI,
                    fromDataBuffer: await config.dataSource?.audioData,
                  );
                  refreshUI();
                } else if (value.isRunning) {
                  await controller.pausePlay();
                } else if (value.isPause) {
                  await controller.resumePlay();
                }
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Visibility(
                    visible: value.isWorked,
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

  //构建倍速控制按钮
  Widget _buildSpeedAction() {
    if (!config.allowSpeed) return EmptyBox();
    return ValueListenableBuilder<double>(
      valueListenable: speed,
      builder: (context, value, child) {
        return PopupMenuButton<double>(
          initialValue: value,
          child: Text(
            "x$value",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onSelected: (value) async {
            await controller.setSpeed(value);
            speed.setValue(value);
          },
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
      valueListenable: volume,
      builder: (context, value, child) {
        var icon;
        if (value > 0.5) icon = Icons.volume_up_rounded;
        if (value > 0 && value <= 0.5) icon = Icons.volume_down_rounded;
        if (value <= 0) icon = Icons.volume_mute_rounded;
        return PopupMenuButton<double>(
          child: Icon(icon),
          initialValue: value,
          onSelected: (value) async {
            await controller.setVolume(value);
            volume.setValue(value);
          },
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
