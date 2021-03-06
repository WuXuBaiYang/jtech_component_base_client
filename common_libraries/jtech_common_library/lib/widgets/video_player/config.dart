import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 视频播放器配置文件
* @author jtechjh
* @Time 2021/8/6 5:12 下午
*/
class VideoPlayerConfig extends BaseConfig{
  //视频组件容器尺寸
  final Size? size;

  //背景色
  final Color backgroundColor;

  //初始化构造器
  final WidgetBuilder? initialBuilder;

  //对齐方式
  final Alignment align;

  VideoPlayerConfig({
    this.size,
    this.backgroundColor = Colors.grey,
    this.initialBuilder,
    this.align = Alignment.center,
  });

  @override
  VideoPlayerConfig copyWith({
    Size? size,
    Color? backgroundColor,
    WidgetBuilder? initialBuilder,
    Alignment? align,
  }) {
    return VideoPlayerConfig(
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      initialBuilder: initialBuilder ?? this.initialBuilder,
      align: align ?? this.align,
    );
  }
}
