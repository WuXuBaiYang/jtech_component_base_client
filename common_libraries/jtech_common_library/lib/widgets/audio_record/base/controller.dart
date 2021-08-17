import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:record/record.dart';

/*
* 音频录制组件控制器
* @author jtechjh
* @Time 2021/8/9 2:24 下午
*/
class JAudioRecordController extends BaseController {
  //录音器模块
  final Record _recorder;

  //当前录音状态
  final ValueChangeNotifier<AudioState> _audioState;

  //记录当前录音文件集合
  final ListValueChangeNotifier<JFileInfo> _audioList;

  //最大可录音数量
  final int _maxRecordCount;

  //判断当前是否正在录音
  bool get isRecording => _audioState.value == AudioState.progressing;

  //判断当前是否正在暂停
  bool get isPause => _audioState.value == AudioState.pause;

  //判断当前是否停止
  bool get isStopped => _audioState.value == AudioState.stopped;

  //判断是否已达到最大录音数量
  bool get hasMaxCount => _maxRecordCount >= _audioList.length;

  //获取所有已录音文件
  List<JFileInfo> get audioFiles => _audioList.value;

  JAudioRecordController({int maxRecordCount = 1})
      : this._recorder = Record(),
        this._maxRecordCount = maxRecordCount,
        this._audioList = ListValueChangeNotifier.empty(),
        this._audioState = ValueChangeNotifier(AudioState.stopped);

  //获取录音器状态监听器
  ValueListenable<AudioState> get audioStateListenable => _audioState;

  //启动录制
  Future<void> startRecord({
    required String path,
  }) async {
    if (isStopped && !hasMaxCount) {
      await _recorder.start(
        path: path,
        encoder: AudioEncoder.AAC,
        bitRate: 128000,
        samplingRate: 44100.0,
      );
      _audioState.setValue(AudioState.progressing);
    }
  }

  //暂停录制
  Future<void> pauseRecord() async {
    if (isRecording) {
      await _recorder.pause();
      _audioState.setValue(AudioState.pause);
    }
  }

  //恢复录制
  Future<void> resumeRecord() async {
    if (isPause) {
      await _recorder.resume();
      _audioState.setValue(AudioState.progressing);
    }
  }

  //停止录制
  Future<String?> stopRecord() async {
    if (isStopped) return null;
    var result = await _recorder.stop();
    if (null != result) {
      var file = File(result);
      _audioList.insertValue(0, [
        JFileInfo(
          path: file.absolute.path,
          length: await file.length(),
        ),
      ]);
    }
    _audioState.setValue(AudioState.stopped);
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    //销毁录音器
    _recorder.dispose();
    _audioList.clear();
  }
}
