import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频播放器配置文件
* @author jtechjh
* @Time 2021/8/10 9:58 上午
*/
class FullAudioPlayerConfig extends BaseConfig {
  //是否支持音量控制功能
  bool allowVolume;

  //是否支持倍速播放功能
  bool allowSpeed;

  //是否支持扬声器，听筒切换功能
  bool allowSpeakerToggle;

  //标题部分组件
  Widget? title;

  //标题部分内间距
  EdgeInsets titlePadding;

  FullAudioPlayerConfig({
    this.allowVolume = true,
    this.allowSpeed = true,
    this.allowSpeakerToggle = false,
    this.title,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  FullAudioPlayerConfig copyWith({
    bool? allowVolume,
    bool? allowSpeed,
    bool? allowSpeakerToggle,
    Widget? title,
    bool? centerTitle,
    EdgeInsets? titlePadding,
  }) {
    return FullAudioPlayerConfig(
      allowVolume: allowVolume ?? this.allowVolume,
      allowSpeed: allowSpeed ?? this.allowSpeed,
      allowSpeakerToggle: allowSpeakerToggle ?? this.allowSpeakerToggle,
      title: title ?? this.title,
      titlePadding: titlePadding ?? this.titlePadding,
    );
  }
}
