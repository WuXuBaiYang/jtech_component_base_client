import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

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
  BaseState<BaseStatefulWidget> getState() => _JAudioPlayerState();
}

/*
* 音频播放器组件状态
* @author jtechjh
* @Time 2021/8/13 10:49 上午
*/
class _JAudioPlayerState extends BaseState<JAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.config.margin,
      elevation: widget.config.elevation,
      color: widget.config.backgroundColor,
      child: Container(
        padding: widget.config.padding,
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
      padding: widget.config.titlePadding,
      child: Row(
        children: [
          widget.config.title ?? EmptyBox(),
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
      stream: widget.controller.onProgress,
      builder: (context, snap) {
        if (!snap.hasData) return EmptyBox();
        var max = snap.data!.duration;
        var curr = snap.data!.position;
        var ratio = snap.data!.ratio;
        var fCurr = jCommon.tools.durationFormat.formatMMSS(curr);
        var fMax = jCommon.tools.durationFormat.formatMMSS(max);
        bool isPlaying = widget.controller.isPlaying;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            max.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 24),
                    child: LinearProgressIndicator(
                      value: isPlaying ? null : 0,
                      backgroundColor: isPlaying ? null : Colors.grey,
                    ),
                  )
                : Slider(
                    value: ratio,
                    onChanged: (value) {
                      var duration = max.multiply(value);
                      widget.controller.seekToPlay(duration);
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
      valueListenable: widget.controller.audioStateListenable,
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
                  await widget.controller.startPlay(
                    fromURI: widget.config.dataSource?.audioURI,
                    fromDataBuffer: await widget.config.dataSource?.audioData,
                    startAt: widget.config.startAt,
                  );
                } else if (value == AudioState.playing) {
                  await widget.controller.pausePlay();
                } else if (value == AudioState.pause) {
                  await widget.controller.resumePlay();
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
                      onPressed: () => widget.controller.stopPlay(),
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
    if (!widget.config.allowSpeakerToggle) return EmptyBox();
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.speakerToggleListenable,
      builder: (context, value, child) {
        var iconData =
            value ? Icons.hearing_rounded : Icons.hearing_disabled_rounded;
        return IconButton(
          icon: Icon(iconData),
          onPressed: () => widget.controller.speakerToggle(),
        );
      },
    );
  }

  //构建倍速控制按钮
  Widget _buildSpeedAction() {
    if (!widget.config.allowSpeed) return EmptyBox();
    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.audioSpeedListenable,
      builder: (context, value, child) {
        return JPopupButton.text<double>(
          context,
          child: Row(
            children: [
              Icon(Icons.speed, size: 20),
              SizedBox(width: 2),
              Text(
                "x${value.toStringAsFixed(1)}",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          builder: (_, dismiss) => _buildSlidePopup(
            dismiss: dismiss,
            value: value,
            max: 3.0,
            onValueLabelChange: (v) => "x${v.toStringAsFixed(1)}",
          ),
          size: slidePopupSize,
          onPopupDismiss: (result) =>
              widget.controller.setSpeed(result ?? value),
        );
      },
    );
  }

  //构建音量控制按钮
  Widget _buildVolumeAction() {
    if (!widget.config.allowVolume) return EmptyBox();
    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.audioVolumeListenable,
      builder: (context, value, child) {
        var icon;
        if (value > 0.5) icon = Icons.volume_up_rounded;
        if (value > 0 && value <= 0.5) icon = Icons.volume_down_rounded;
        if (value <= 0) icon = Icons.volume_mute_rounded;
        return JPopupButton.icon<double>(
          context,
          icon: Icon(icon),
          builder: (_, dismiss) => _buildSlidePopup(
            dismiss: dismiss,
            value: value,
            onValueLabelChange: (v) => "${(v * 100).toInt()}%",
          ),
          size: slidePopupSize,
          onPopupDismiss: (result) =>
              widget.controller.setVolume(result ?? value),
        );
      },
    );
  }

  //滑动弹层尺寸
  final Size slidePopupSize = Size(55, 210);

  //构建滑动弹层
  Widget _buildSlidePopup({
    required void Function(double result) dismiss,
    double value = 0.0,
    double max = 1.0,
    Function(double value)? onValueLabelChange,
  }) {
    return SizedBox.fromSize(
      child: RotatedBox(
        quarterTurns: 135,
        child: StatefulBuilder(
          builder: (context, setState) => JCard.row(
            padding: EdgeInsets.only(left: null != onValueLabelChange ? 8 : 0),
            borderRadius: BorderRadius.circular(8),
            children: [
              Visibility(
                child: RotatedBox(
                  quarterTurns: 45,
                  child: Text(
                    onValueLabelChange?.call(value) ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                visible: null != onValueLabelChange,
              ),
              Expanded(
                child: Slider(
                  value: value,
                  max: max,
                  autofocus: true,
                  onChanged: (v) => setState(() => value = v),
                  onChangeEnd: (v) => dismiss(v),
                ),
              ),
            ],
          ),
        ),
      ),
      size: slidePopupSize,
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
  }
}
