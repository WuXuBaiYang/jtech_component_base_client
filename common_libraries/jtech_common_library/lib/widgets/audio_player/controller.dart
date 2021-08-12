import 'dart:async';
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

  //音量控制
  final ValueChangeNotifier<double> _audioVolume;

  //速度控制
  final ValueChangeNotifier<double> _audioSpeed;

  //扬声器听筒切换状态
  final ValueChangeNotifier<bool> _speakerToggle;

  //播放进度管理
  final StreamController<PlayProgress> _positionController =
      StreamController<PlayProgress>.broadcast();

  JAudioPlayerController({
    double volume = 1.0,
    double speed = 1.0,
    bool isSpeaker = true,
  })  : this._player = AudioPlayer(),
        this._speakerToggle = ValueChangeNotifier(isSpeaker),
        this._audioVolume = ValueChangeNotifier(volume),
        this._audioSpeed = ValueChangeNotifier(speed),
        this._audioState = ValueChangeNotifier(AudioState.stopped) {
    //设置扬声器播放状态
    _player.playingRouteState =
        isSpeakerPlay ? PlayingRoute.SPEAKERS : PlayingRoute.EARPIECE;
    //监听播放器状态变化
    _player.onNotificationPlayerStateChanged
        .listen((event) => _onStateChange(event));
    _player.onPlayerStateChanged.listen((event) => _onStateChange(event));
    _player.onDurationChanged.listen((event) => this._audioDuration = event);
    _player.onAudioPositionChanged.listen((event) => _positionController
        .add(PlayProgress.from(duration: _audioDuration, position: event)));
  }

  //获取播放器状态监听器
  ValueListenable<AudioState> get audioStateListenable => _audioState;

  //获取播放器音量监听器
  ValueListenable<double> get audioVolumeListenable => _audioVolume;

  //获取播放器速度监听器
  ValueListenable<double> get audioSpeedListenable => _audioSpeed;

  //获取扬声器播放状态监听器
  ValueListenable<bool> get speakerToggleListenable => _speakerToggle;

  //获取当前音量
  double get audioVolume => _audioVolume.value;

  //获取当前播放速度
  double get audioSpeed => _audioSpeed.value;

  //获取当前扬声器播放状态
  bool get isSpeakerPlay => _speakerToggle.value;

  //判断当前是否正在播放
  bool get isPlaying => _audioState.value == AudioState.playing;

  //判断当前是否正在暂停
  bool get isPause => _audioState.value == AudioState.pause;

  //判断当前是否停止
  bool get isStopped => _audioState.value == AudioState.stopped;

  //获取播放进度
  Stream<PlayProgress> get onProgress => _positionController.stream;

  //记录音频总时长
  Duration _audioDuration = Duration.zero;

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
          volume: audioVolume,
          position: startAt,
          stayAwake: true,
        );
      } else if (null != fromDataBuffer) {
        result = await _player.playBytes(
          fromDataBuffer,
          volume: audioVolume,
          position: startAt,
          stayAwake: true,
        );
      }
      if (_setupSuccess(result)) {
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
    if (isStopped) return;
    var result = await _player.stop();
    if (_setupSuccess(result)) _audioState.setValue(AudioState.stopped);
  }

  //拖动播放进度
  Future<bool> seekToPlay(Duration duration) async {
    if (isStopped || duration.greaterThan(_audioDuration)) return false;
    var result = await _player.seek(duration);
    return _setupSuccess(result);
  }

  //设置音量
  Future<bool> setVolume(double volume) async {
    if (volume < 0 || volume > 1) return false;
    var result = await _player.setVolume(volume);
    if (_setupSuccess(result)) {
      return _audioVolume.setValue(volume);
    }
    return false;
  }

  //设置播放速度
  Future<bool> setSpeed(double speed) async {
    if (speed < 0 || speed > 3) return false;
    var result = await _player.setPlaybackRate(playbackRate: speed);
    if (_setupSuccess(result)) {
      return _audioSpeed.setValue(speed);
    }
    return false;
  }

  //设置扬声器与听筒播放状态切换
  Future<bool> speakerToggle() async {
    var result = await _player.earpieceOrSpeakersToggle();
    if (_setupSuccess(result)) {
      return _speakerToggle.setValue(!isSpeakerPlay);
    }
    return false;
  }

  //判断播放器设置是否成功
  bool _setupSuccess(int result) => 1 == result;

  @override
  void addListener(VoidCallback listener) {
    _audioState.addListener(listener);
    _audioVolume.addListener(listener);
    _audioSpeed.addListener(listener);
    super.addListener(listener);
  }

  //播放器状态变化
  _onStateChange(PlayerState event) async {
    switch (event) {
      case PlayerState.STOPPED:
        _positionController.add(PlayProgress.zero());
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
