import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频播放器组件控制器
* @author jtechjh
* @Time 2021/8/9 5:35 下午
*/
class JAudioPlayerController extends BaseAudioController {
  //播放器对象
  final AudioPlayer _player;

  //音量控制
  final ValueChangeNotifier<double> _audioVolume;

  //速度控制
  final ValueChangeNotifier<double> _audioSpeed;

  //扬声器听筒切换状态
  final ValueChangeNotifier<bool> _speakerToggle;

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

  //记录音频总时长
  Duration _maxDuration = Duration.zero;

  JAudioPlayerController({
    double volume = 1.0,
    double speed = 1.0,
    bool isSpeaker = true,
  })  : this._player = AudioPlayer(),
        this._speakerToggle = ValueChangeNotifier(isSpeaker),
        this._audioVolume = ValueChangeNotifier(volume),
        this._audioSpeed = ValueChangeNotifier(speed) {
    //设置扬声器播放状态
    _player.playingRouteState =
        isSpeakerPlay ? PlayingRoute.SPEAKERS : PlayingRoute.EARPIECE;
    //监听播放器状态变化
    _player.onNotificationPlayerStateChanged
        .listen((event) => _onStateChange(event));
    _player.onPlayerStateChanged.listen((event) => _onStateChange(event));
    _player.onDurationChanged.listen((event) => this._maxDuration = event);
    _player.onAudioPositionChanged.listen((event) => updateAudioProgress(
        AudioProgress.from(duration: _maxDuration, position: event)));
  }

  //开始播放
  Future<bool> start({
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
        return updateAudioState(AudioState.progressing);
      }
    }
    return false;
  }

  //暂停播放
  Future<void> pause() async {
    if (isProgressing) {
      var result = await _player.pause();
      if (_setupSuccess(result)) updateAudioState(AudioState.pause);
    }
  }

  //恢复播放
  Future<void> resume() async {
    if (isPause) {
      var result = await _player.resume();
      if (_setupSuccess(result)) updateAudioState(AudioState.progressing);
    }
  }

  //停止播放
  Future<void> stop() async {
    if (isStopped) return;
    var result = await _player.stop();
    if (_setupSuccess(result)) updateAudioState(AudioState.stopped);
  }

  //拖动播放进度
  Future<bool> seekToPlay(Duration duration) async {
    if (isStopped || duration.greaterThan(_maxDuration)) return false;
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
    super.addListener(listener);
    _audioVolume.addListener(listener);
    _audioSpeed.addListener(listener);
  }

  //播放器状态变化
  _onStateChange(PlayerState event) async {
    switch (event) {
      case PlayerState.STOPPED:
        updateAudioProgress(AudioProgress.zero());
        updateAudioState(AudioState.stopped);
        break;
      case PlayerState.PLAYING:
        updateAudioState(AudioState.progressing);
        break;
      case PlayerState.PAUSED:
        updateAudioState(AudioState.pause);
        break;
      case PlayerState.COMPLETED:
        var result = await _player.release();
        if (_setupSuccess(result)) {
          updateAudioState(AudioState.stopped);
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
