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

  //文件存储路径(自定义存储路径时，不需要指定文件类型)
  final String? savePath;

  AudioRecordConfig({
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(15),
    this.elevation = 8.0,
    this.backgroundColor = Colors.white,
    this.onRecordFinish,
    this.savePath,
  });

  @override
  AudioRecordConfig copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? backgroundColor,
    OnRecordFinish? onRecordFinish,
    String? savePath,
  }) {
    return AudioRecordConfig(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      onRecordFinish: onRecordFinish ?? this.onRecordFinish,
      savePath: savePath ?? this.savePath,
    );
  }
}
