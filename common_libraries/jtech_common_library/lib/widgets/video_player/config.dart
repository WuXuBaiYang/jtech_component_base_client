import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* 播放器配置
* @author jtechjh
* @Time 2021/8/4 10:15 上午
*/
class VideoPlayerConfig {
  //播放器模式
  PlayerMode mode;

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

  //播放按钮组件
  Widget? playButton;

  VideoPlayerConfig({
    this.dataSource = "",
    this.sourceType = SourceType.net,
    this.autoPlay = false,
    this.mode = PlayerMode.video,
    this.size,
    this.color = Colors.black,
    this.playButton,
  });

  VideoPlayerConfig copyWith({
    String? dataSource,
    SourceType? sourceType,
    PlayerMode? mode,
    bool? autoPlay,
    Size? size,
    Color? color,
    Widget? playButton,
  }) {
    return VideoPlayerConfig(
      dataSource: dataSource ?? this.dataSource,
      sourceType: sourceType ?? this.sourceType,
      mode: mode ?? this.mode,
      autoPlay: autoPlay ?? this.autoPlay,
      size: size ?? this.size,
      color: color ?? this.color,
      playButton: playButton ?? this.playButton,
    );
  }
}

/*
* 播放器模式枚举
* @author jtechjh
* @Time 2021/8/4 10:15 上午
*/
enum PlayerMode {
  //播放器模式
  video,
  //缩略图模式
  thumbnail,
  //直播拉流模式
  live,
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
