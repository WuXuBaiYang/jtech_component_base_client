import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:record/record.dart';

/*
* 音频录制组件控制器
* @author jtechjh
* @Time 2021/8/9 2:24 下午
*/
class JAudioRecordController extends BaseAudioController {
  //录音器模块
  final Record _recorder;

  //记录当前录音文件集合
  final ListValueChangeNotifier<JFileInfo> _audioList;

  //最大可录音数量
  final int _maxRecordCount;

  //最大录制时长
  final Duration _maxDuration;

  //判断是否已达到最大录音数量
  bool get hasMaxCount => _audioList.length >= _maxRecordCount;

  //获取所有已录音文件
  List<JFileInfo> get audioFiles => _audioList.value;

  //录音文件集合变化监听
  ValueListenable<List<JFileInfo>> get audioListListenable => _audioList;

  JAudioRecordController({
    int maxRecordCount = 1,
    Duration? maxDuration,
  })  : this._recorder = Record(),
        this._maxDuration = maxDuration ?? Duration(seconds: 60),
        this._maxRecordCount = maxRecordCount,
        this._audioList = ListValueChangeNotifier.empty();

  //移除已有文件记录
  void removeRecordFile(JFileInfo fileInfo) => _audioList.removeValue(fileInfo);

  //启动录制
  Future<void> start(
    BuildContext context, {
    required String path,
  }) async {
    if (isStopped && !hasMaxCount) {
      //检查权限
      bool hasPermission = await jPermission.checkAllGranted(
        context,
        permissions: [
          PermissionRequest.storage(),
          PermissionRequest.microphone(),
        ],
      );
      if (!hasPermission) return;
      await _recorder.start(
        path: path,
        encoder: AudioEncoder.AAC,
        bitRate: 128000,
        samplingRate: 44100.0,
      );
      updateAudioState(AudioState.progressing);
      _startTimer();
    }
  }

  //暂停录制
  Future<void> pause() async {
    if (isProgressing) {
      await _recorder.pause();
      updateAudioState(AudioState.pause);
      _cancelTimer();
    }
  }

  //恢复录制
  Future<void> resume() async {
    if (isPause) {
      await _recorder.resume();
      updateAudioState(AudioState.progressing);
      _startTimer();
    }
  }

  //停止录制
  Future<String?> stop() async {
    if (isStopped) return null;
    var result = await _recorder.stop();
    if (null != result) {
      _audioList.insertValue(0, [
        await JFileInfo.fromPath(result),
      ]);
    }
    updateAudioState(AudioState.stopped);
    _recordDuration = Duration.zero;
    _cancelTimer();
    updateAudioProgress(AudioProgress.from(
      position: _recordDuration,
      duration: _maxDuration,
    ));
    return result;
  }

  //记录计时器id
  String _timerKey = "";

  //已录制时长
  Duration _recordDuration = Duration.zero;

  //启动计时器
  void _startTimer() {
    _timerKey = jTimer.countdown(
      maxDuration: _maxDuration.subtract(_recordDuration),
      callback: (remaining, passTime) {
        _recordDuration = passTime;
        updateAudioProgress(AudioProgress.from(
          position: _recordDuration,
          duration: _maxDuration,
        ));
      },
      onFinish: () => stop(),
    );
    updateAudioProgress(AudioProgress.from(
      position: _recordDuration,
      duration: _maxDuration,
    ));
  }

  //取消计时器
  void _cancelTimer() => jTimer.cancel(_timerKey);

  @override
  void dispose() {
    super.dispose();
    //销毁录音器
    _recorder.dispose();
    _audioList.clear();
    _cancelTimer();
  }
}
