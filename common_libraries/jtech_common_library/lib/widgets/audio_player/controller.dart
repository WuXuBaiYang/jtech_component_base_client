import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/tools/data_format.dart';

/*
* 音频播放器组件控制器
* @author jtechjh
* @Time 2021/8/9 5:35 下午
*/
class JAudioPlayerController extends BaseController {
  //播放器对象
  final AudioPlayer _player;

  //播放器状态管理
  final ValueChangeNotifier<AudioState> _audioState;

  JAudioPlayerController()
      : this._player = AudioPlayer(),
        this._audioState = ValueChangeNotifier(AudioState.stopped) {
    //监听播放器状态变化
    _player.onNotificationPlayerStateChanged
        .listen((event) => _onStateChange(event));
    _player.onPlayerStateChanged.listen((event) => _onStateChange(event));
  }

  //获取播放器状态监听器
  ValueListenable<AudioState> get audioStateListenable => _audioState;

  //判断当前是否正在播放
  bool get isPlaying => _audioState.value == AudioState.playing;

  //判断当前是否正在暂停
  bool get isPause => _audioState.value == AudioState.pause;

  //判断当前是否停止
  bool get isStopped => _audioState.value == AudioState.stopped;

  //开始播放
  Future<bool> startPlay({
    String? fromURI,
    Uint8List? fromDataBuffer,
    Duration startAt = Duration.zero,
  }) async {
    if (isStopped) {
      var result;
      if (null != fromURI) {
        result = await _player.play(
          fromURI,
          isLocal: _player.isLocalUrl(fromURI),
          position: startAt,
          stayAwake: true,
        );
      } else if (null != fromDataBuffer) {
        result = await _player.playBytes(
          fromDataBuffer,
          position: startAt,
          stayAwake: true,
        );
      }
      if (_setupSuccess(result)) {
        _audioDuration = Duration(
          milliseconds: await _player.getDuration(),
        );
        return _audioState.setValue(AudioState.playing);
      }
    }
    return false;
  }

  //暂停播放
  Future<void> pausePlay() async {
    if (!isPlaying) return;
    var result = await _player.pause();
    if (_setupSuccess(result)) _audioState.setValue(AudioState.pause);
  }

  //恢复播放
  Future<void> resumePlay() async {
    if (!isPause) return;
    var result = await _player.resume();
    if (_setupSuccess(result)) _audioState.setValue(AudioState.playing);
  }

  //停止播放
  Future<void> stopPlay() async {
    if (!isStopped) return;
    var result = await _player.stop();
    if (_setupSuccess(result)) _audioState.setValue(AudioState.stopped);
  }

  //拖动播放进度
  Future<bool> seekToPlay(Duration duration) async {
    if (isStopped) return false;
    var result = await _player.seek(duration);
    return _setupSuccess(result);
  }

  //设置音量
  Future<bool> setVolume(double volume) async {
    var result = await _player.setVolume(volume);
    return _setupSuccess(result);
  }

  //设置播放速度
  Future<bool> setSpeed(double speed) async {
    var result = await _player.setPlaybackRate(playbackRate: speed);
    return _setupSuccess(result);
  }

  //判断播放器设置是否成功
  bool _setupSuccess(int result) => 1 == result;

  //记录音频总时长
  Duration? _audioDuration;

  //获取播放进度
  Stream<PlayProgress> get onProgress => _player.onAudioPositionChanged
      .map<PlayProgress>((event) => PlayProgress.from(
          duration: _audioDuration ?? Duration.zero, position: event));

  @override
  void addListener(VoidCallback listener) {
    _audioState.addListener(listener);
    super.addListener(listener);
  }

  //播放器状态变化
  _onStateChange(PlayerState event) async {
    switch (event) {
      case PlayerState.STOPPED:
        _audioState.setValue(AudioState.stopped);
        break;
      case PlayerState.PLAYING:
        _audioState.setValue(AudioState.playing);
        break;
      case PlayerState.PAUSED:
        _audioState.setValue(AudioState.pause);
        break;
      case PlayerState.COMPLETED:
        var result = await _player.release();
        if (_setupSuccess(result)) {
          _audioState.setValue(AudioState.stopped);
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    _player.dispose();
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

  //判断总播放时长是否为空
  bool get isEmpty => duration.inMicroseconds == 0;

  //获取播放进度
  double get ratio => position.divide(duration);

  PlayProgress.zero()
      : this.duration = Duration.zero,
        this.position = Duration.zero;

  PlayProgress.from({
    required this.duration,
    required this.position,
  });
}

/*
* 音频状态管理
* @author jtechjh
* @Time 2021/8/10 1:19 下午
*/
enum AudioState {
  playing,
  stopped,
  pause,
}
