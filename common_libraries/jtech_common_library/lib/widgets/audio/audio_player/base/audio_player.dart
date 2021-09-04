import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频播放器
* @author wuxubaiyang
* @Time 2021/8/7 1:26
*/
class JAudioPlayer extends BaseStatefulWidgetMultiply {
  //播放控制器
  final JAudioPlayerController controller;

  //音频播放器配置文件
  final AudioPlayerConfig config;

  //播放资源管理
  final AudioDataSource dataSource;

  JAudioPlayer({
    required BaseJAudioPlayerState currentState,
    required this.controller,
    required this.dataSource,
    required this.config,
  }) : super(currentState: currentState);

  //构建完整版音频播放器
  static JAudioPlayer full({
    //默认配置结构
    required AudioDataSource dataSource,
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    //完整播放器参数
    FullAudioPlayerConfig? fullConfig,
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
  }) {
    return JAudioPlayer(
      controller: controller ?? JAudioPlayerController(),
      dataSource: dataSource,
      config: (config ?? AudioPlayerConfig()).copyWith(
        autoPlay: autoPlay,
        startAt: startAt,
        margin: margin,
        padding: padding,
        elevation: elevation,
      ),
      currentState: JAudioPlayerFullState(
        config: (fullConfig ?? FullAudioPlayerConfig()).copyWith(
          title: title,
          titlePadding: titlePadding,
        ),
      ),
    );
  }

  //构建简易音频播放器
  static JAudioPlayer simple({
    //默认配置结构
    required AudioDataSource dataSource,
    JAudioPlayerController? controller,
    AudioPlayerConfig? config,
    bool? autoPlay,
    Duration? startAt,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
  }) {
    return JAudioPlayer(
      controller: controller ?? JAudioPlayerController(),
      currentState: JAudioPlayerSimpleState(),
      dataSource: dataSource,
      config: (config ?? AudioPlayerConfig()).copyWith(
        autoPlay: autoPlay,
        startAt: startAt,
        margin: margin,
        padding: padding ?? EdgeInsets.all(8),
        elevation: elevation,
      ),
    );
  }
}

/*
* 音频播放器组件状态基类
* @author jtechjh
* @Time 2021/8/17 9:06 上午
*/
abstract class BaseJAudioPlayerState extends BaseState<JAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    return JCard.single(
      margin: widget.config.margin,
      padding: widget.config.padding,
      elevation: widget.config.elevation,
      color: widget.config.backgroundColor,
      child: buildAudioContent(context),
    );
  }

  //构建音频播放器容器
  Widget buildAudioContent(BuildContext context);

  //创建进度拖动/指示条
  Widget buildProgressSlider(double ratio, Duration max) {
    bool isPlaying = widget.controller.isProgressing;
    if (max.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 24),
        child: LinearProgressIndicator(
          value: isPlaying ? null : 0,
          backgroundColor: isPlaying ? null : Colors.grey,
        ),
      );
    }
    return Slider(
      value: ratio,
      onChanged: (value) {
        var duration = max.multiply(value);
        widget.controller.seekToPlay(duration);
      },
    );
  }

  //创建进度文字提示
  Widget buildProgressLabel(Duration curr, Duration max,
      {TextStyle? textStyle}) {
    var fCurr = jDurationFormat.formatMMSS(curr);
    var fMax = jDurationFormat.formatMMSS(max);
    return Text(
      "$fCurr/$fMax",
      style: textStyle ?? TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  //构建播放器进度部分
  Widget buildPlayerProgress() {
    return StreamBuilder<AudioProgress>(
      initialData: AudioProgress.zero(),
      stream: widget.controller.onProgress,
      builder: (context, snap) {
        if (!snap.hasData) return EmptyBox();
        var max = snap.data!.duration;
        var curr = snap.data!.position;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12),
            buildProgressSlider(snap.data!.ratio, max),
            buildProgressLabel(curr, max),
          ],
        );
      },
    );
  }

  //构建播放按钮
  Widget buildPlayButton(AudioState state,
      {double iconSize = 60, Color? iconColor}) {
    return IconButton(
      icon: Icon(state == AudioState.progressing
          ? Icons.pause_circle_outline_rounded
          : Icons.play_circle_outline_rounded),
      iconSize: iconSize,
      color: iconColor,
      onPressed: () async {
        if (state == AudioState.stopped) {
          await widget.controller.start(
            fromURI: widget.dataSource.audioURI,
            fromDataBuffer: await widget.dataSource.audioData,
            startAt: widget.config.startAt,
          );
        } else if (state == AudioState.progressing) {
          await widget.controller.pause();
        } else if (state == AudioState.pause) {
          await widget.controller.resume();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
  }
}
