import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/audio_player/config.dart';
import 'package:jtech_common_library/widgets/audio_player/controller.dart';

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
  Widget build(BuildContext context) {
    return Card(
      margin: config.margin,
      elevation: config.elevation,
      color: config.backgroundColor,
      child: Container(
        padding: config.padding,
      ),
    );
  }
}
