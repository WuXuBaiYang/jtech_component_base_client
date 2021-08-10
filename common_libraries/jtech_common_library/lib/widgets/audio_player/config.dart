import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jtech_common_library/base/config.dart';

/*
* 音频播放器配置文件
* @author jtechjh
* @Time 2021/8/10 9:58 上午
*/
class AudioPlayerConfig extends BaseConfig {
  //外间距
  EdgeInsetsGeometry margin;

  //内间距
  EdgeInsetsGeometry padding;

  //悬浮高度
  double? elevation;

  //卡片背景色
  Color backgroundColor;

  //资源管理
  DataSource? dataSource;

  //是否自动播放
  bool autoPlay;

  //默认播放进度
  Duration startAt;

  //默认音量
  double? volume;

  //默认播放速度
  double? speed;

  //是否支持音量控制功能
  bool allowVolume;

  //是否支持倍速播放功能
  bool allowSpeed;

  //标题部分组件
  Widget? title;

  //标题是否剧中
  bool centerTitle;

  AudioPlayerConfig({
    this.dataSource,
    this.autoPlay = false,
    this.startAt = Duration.zero,
    this.volume,
    this.speed,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(15),
    this.elevation,
    this.backgroundColor = Colors.white,
    this.allowVolume = true,
    this.allowSpeed = true,
    this.title,
    this.centerTitle = true,
  });

  @override
  AudioPlayerConfig copyWith({
    DataSource? dataSource,
    bool? autoPlay,
    Duration? startAt,
    double? volume,
    double? speed,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? backgroundColor,
    bool? allowVolume,
    bool? allowSpeed,
    Widget? title,
    bool? centerTitle,
  }) {
    return AudioPlayerConfig(
      dataSource: dataSource ?? this.dataSource,
      autoPlay: autoPlay ?? this.autoPlay,
      startAt: startAt ?? this.startAt,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      allowVolume: allowVolume ?? this.allowVolume,
      allowSpeed: allowSpeed ?? this.allowSpeed,
      title: title ?? this.title,
      centerTitle: centerTitle ?? this.centerTitle,
    );
  }
}

/*
* 音频播放器资源管理类
* @author jtechjh
* @Time 2021/8/10 9:58 上午
*/
class DataSource {
  //asset资源标头
  static final String _assetHead = "assets:";

  //网络地址或本地文件地址
  String? _sourceUri;

  //缓存文件流
  Uint8List? _sourceData;

  //加载远程资源地址
  DataSource.net(this._sourceUri);

  //加载本地文件资源地址
  DataSource.file(File file) : this._sourceUri = file.absolute.path;

  //加载assets资源
  DataSource.asset(String assetName, {String? package})
      : this._sourceUri =
            "$_assetHead${null == package ? assetName : "packages/$package/$assetName"}";

  //加载内存资源
  DataSource.memory(this._sourceData);

  //获取路径资源地址
  String? get audioURI {
    if (null == _sourceUri || _isAssetSource) return null;
    return _sourceUri;
  }

  //获取内存资源对象
  Future<Uint8List?> get audioData async {
    if (null != _sourceData) return _sourceData;
    if (_isAssetSource) {
      var result = (await rootBundle.load(_assetPath!));
      _sourceData = result.buffer.asUint8List();
    }
    return _sourceData;
  }

  //判断资源类型是否为asset
  bool get _isAssetSource => _sourceUri?.startsWith(_assetHead) ?? false;

  //获取完整的asset路径
  String? get _assetPath =>
      _isAssetSource ? _sourceUri!.replaceFirst(_assetHead, "") : null;
}
