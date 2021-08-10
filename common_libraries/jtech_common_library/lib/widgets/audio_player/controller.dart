import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:jtech_common_library/base/controller.dart';

/*
* 音频播放器组件控制器
* @author jtechjh
* @Time 2021/8/9 5:35 下午
*/
class JAudioPlayerController extends BaseController {
  //音频播放控制器
  final FlutterSoundPlayer _player;

  JAudioPlayerController() : this._player = FlutterSoundPlayer();

  //开始播放
  Future<Stream<PlayProgress>?> startPlay({
    String? fromURI,
    Uint8List? fromDataBuffer,
    VoidCallback? onFinished,
  }) async {
    await _player.openAudioSession();
    await _player.startPlayer(
      fromURI: fromURI,
      fromDataBuffer: fromDataBuffer,
      whenFinished: () => onFinished?.call(),
    );
    return onProgress;
  }

  //暂停播放
  Future<void> pausePlay() {
    return _player.pausePlayer();
  }

  //恢复播放
  Future<void> resumePlay() {
    return _player.resumePlayer();
  }

  //停止播放
  Future<void> stopPlay() {
    return _player.stopPlayer();
  }

  //拖动播放进度
  Future<void> seekToPlay(Duration duration) {
    return _player.seekToPlayer(duration);
  }

  //设置音量
  Future<void> setVolume(double volume) {
    return _player.setVolume(volume);
  }

  //设置播放速度
  Future<void> setSpeed(double speed) {
    return _player.setSpeed(speed);
  }

  //获取播放进度
  Stream<PlayProgress>? get onProgress =>
      _player.onProgress?.map<PlayProgress>((event) => PlayProgress.from(
          duration: event.duration, position: event.position));

  @override
  void dispose() {
    super.dispose();
    //销毁播放器
    _player.closeAudioSession();
  }
}

/*
* 播放进度对象
* @author jtechjh
* @Time 2021/8/9 5:42 下午
*/
class PlayProgress {
  //音频总时长
  final Duration duration;

  //当前播放时长
  final Duration position;

  PlayProgress.from({
    required this.duration,
    required this.position,
  });
}
