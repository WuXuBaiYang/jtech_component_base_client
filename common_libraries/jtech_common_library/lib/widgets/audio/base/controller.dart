import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频控制器基类
* @author jtechjh
* @Time 2021/8/18 3:35 下午
*/
abstract class BaseAudioController extends BaseController {
  //播放器状态管理
  final ValueChangeNotifier<AudioState> _audioState;

  //播放进度管理
  final StreamController<AudioProgress> _positionController;

  //判断当前是否正在播放
  bool get isProgressing => _audioState.value == AudioState.progressing;

  //判断当前是否正在暂停
  bool get isPause => _audioState.value == AudioState.pause;

  //判断当前是否停止
  bool get isStopped => _audioState.value == AudioState.stopped;

  //获取播放进度
  Stream<AudioProgress> get onProgress => _positionController.stream;

  //获取音频状态监听
  ValueListenable<AudioState> get audioStateListenable => _audioState;

  BaseAudioController()
      : this._audioState = ValueChangeNotifier(AudioState.stopped),
        this._positionController = StreamController<AudioProgress>.broadcast();

  //更新进度
  @protected
  void updateAudioProgress(AudioProgress audioProgress) =>
      _positionController.add(audioProgress);

  //更新音频状态
  @protected
  bool updateAudioState(AudioState state) => _audioState.setValue(state);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    //添加音频状态监听
    _audioState.addListener(listener);
  }
}
