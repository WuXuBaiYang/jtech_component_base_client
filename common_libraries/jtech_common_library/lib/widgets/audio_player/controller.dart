import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/tools/data_format.dart';

/*
* 音频播放器组件控制器
* @author jtechjh
* @Time 2021/8/9 5:35 下午
*/
class JAudioPlayerController extends BaseController {
  //音频播放控制器
  final FlutterSoundPlayer _player;

  //播放器状态管理
  final ValueChangeNotifier<AudioState> _audioState;

  JAudioPlayerController()
      : this._player = FlutterSoundPlayer(),
        this._audioState = ValueChangeNotifier(AudioState.none);

  //获取播放器状态
  AudioState get audioState => _audioState.value;

  //获取播放器状态监听器
  ValueListenable<AudioState> get audioStateListenable => _audioState;

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
      whenFinished: () {
        _audioState.setValue(AudioState.none);
        onFinished?.call();
      },
    );
    _audioState.setValue(AudioState.running);
    return onProgress;
  }

  //暂停播放
  Future<void> pausePlay() async {
    if (!_player.isPlaying) return;
    await _player.pausePlayer();
    _audioState.setValue(AudioState.pause);
  }

  //恢复播放
  Future<void> resumePlay() async {
    if (!_player.isPaused) return;
    await _player.resumePlayer();
    _audioState.setValue(AudioState.running);
  }

  //停止播放
  Future<void> stopPlay() async {
    if (_player.isStopped) return;
    await _player.stopPlayer();
    _audioState.setValue(AudioState.none);
  }

  //拖动播放进度
  Future<void> seekToPlay(Duration duration) async {
    if (!isWorked) return;
    return _player.seekToPlayer(duration);
  }

  //设置音量
  Future<void> setVolume(double volume) async {
    if (!isWorked) return;
    return _player.setVolume(volume);
  }

  //设置播放速度
  Future<void> setSpeed(double speed) async {
    if (!isWorked) return;
    return _player.setSpeed(speed);
  }

  //判断是否正在工作
  bool get isWorked => _player.isPaused || _player.isPlaying;

  //获取播放进度
  Stream<PlayProgress>? get onProgress =>
      _player.onProgress?.map<PlayProgress>((event) => PlayProgress.from(
          duration: event.duration, position: event.position));

  @override
  void addListener(VoidCallback listener) {
    _audioState.addListener(listener);
    super.addListener(listener);
  }

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
  running,
  pause,
  none,
}

/*
* 扩展播放器状态枚举
* @author jtechjh
* @Time 2021/8/10 2:06 下午
*/
extension AudioStateExtension on AudioState {
  //判断是否正在运行中
  bool get isRunning => this == AudioState.running;

  //判断是否正在运作中
  bool get isWorked => this != AudioState.none;

  //判断是否正在暂停
  bool get isPause => this == AudioState.pause;
}
