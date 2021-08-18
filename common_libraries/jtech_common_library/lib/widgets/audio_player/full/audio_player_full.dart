import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 完整音频播放器组件状态
* @author jtechjh
* @Time 2021/8/17 9:08 上午
*/
class JAudioPlayerFullState extends BaseJAudioPlayerState {
  //默认音频播放器配置对象
  final FullAudioPlayerConfig config;

  JAudioPlayerFullState({
    required this.config,
  });

  @override
  Widget buildAudioContent(context) {
    return Column(
      children: [
        _buildTitleContent(),
        buildPlayerProgress(),
        _buildPlayerOptions(),
      ],
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

  //构建播放器操作部分
  Widget _buildPlayerOptions() {
    return ValueListenableBuilder<AudioState>(
      valueListenable: widget.controller.audioStateListenable,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(child: Row(children: [_buildSpeedAction()])),
            buildPlayButton(value),
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
    if (!config.allowSpeakerToggle) return EmptyBox();
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
    if (!config.allowSpeed) return EmptyBox();
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
    if (!config.allowVolume) return EmptyBox();
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
}
