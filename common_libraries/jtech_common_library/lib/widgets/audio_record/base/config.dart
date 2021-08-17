import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//录音结束回调
typedef OnRecordFinish = void Function(String path);

/*
* 录音器组件配置对象
* @author jtechjh
* @Time 2021/8/17 10:12 上午
*/
class AudioRecordConfig extends BaseConfig {
  //外间距
  EdgeInsetsGeometry margin;

  //内间距
  EdgeInsetsGeometry padding;

  //悬浮高度
  double elevation;

  //卡片背景色
  Color backgroundColor;

  //录制结束回调
  final OnRecordFinish? onRecordFinish;

  //最大可录制时长
  final Duration maxDuration;

  AudioRecordConfig({
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(15),
    this.elevation = 8.0,
    this.backgroundColor = Colors.white,
    this.onRecordFinish,
    this.maxDuration = const Duration(seconds: 60),
  });

  @override
  AudioRecordConfig copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? backgroundColor,
    OnRecordFinish? onRecordFinish,
    Duration? maxDuration,
  }) {
    return AudioRecordConfig(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      onRecordFinish: onRecordFinish ?? this.onRecordFinish,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}
