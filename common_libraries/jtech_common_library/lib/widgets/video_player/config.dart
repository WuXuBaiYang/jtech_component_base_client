import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* 播放器配置
* @author jtechjh
* @Time 2021/8/4 10:15 上午
*/
class VideoPlayerConfig {
  //加载完成后自动播放
  bool autoPlay;

  //资源
  String dataSource;

  //资源类型
  SourceType sourceType;

  //视频组件尺寸,为空则使用视频大小
  Size? size;

  //背景色
  Color color;

  //当用户设置大小大于视频尺寸时，视频的居中方式
  Alignment align;

  VideoPlayerConfig({
    this.dataSource = "",
    this.sourceType = SourceType.net,
    this.autoPlay = false,
    this.size,
    this.color = Colors.black,
    this.align = Alignment.center,
  });

  VideoPlayerConfig copyWith({
    String? dataSource,
    SourceType? sourceType,
    bool? autoPlay,
    Size? size,
    Color? color,
    Alignment? align,
  }) {
    return VideoPlayerConfig(
      dataSource: dataSource ?? this.dataSource,
      sourceType: sourceType ?? this.sourceType,
      autoPlay: autoPlay ?? this.autoPlay,
      size: size ?? this.size,
      color: color ?? this.color,
      align: align ?? this.align,
    );
  }
}

/*
* 资源类型枚举
* @author jtechjh
* @Time 2021/8/4 10:17 上午
*/
enum SourceType {
  //本地
  file,
  //网络
  net,
  //assets
  assets,
}
/*
* 播放器状态
* @author jtechjh
* @Time 2021/8/4 10:51 上午
*/
enum PlayerState {
  //无状态
  none,
  //暂停
  pause,
  //播放中
  playing,
  //缓存中
  buffering,
  //错误
  error,
}

/*
* 扩展播放器状态方法
* @author jtechjh
* @Time 2021/8/4 11:21 上午
*/
extension PlayerStateExtension on PlayerState {
  //判断是否正在播放中
  bool get isPlaying => this == PlayerState.playing;

  //判断是否正在暂停
  bool get isPause => this == PlayerState.pause;
}
