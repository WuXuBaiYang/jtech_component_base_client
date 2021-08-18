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
class JAudioRecordController extends BaseController {
  //录音器模块
  final Record _recorder;

  //当前录音状态
  final ValueChangeNotifier<AudioState> _audioState;

  //记录当前录音文件集合
  final ListValueChangeNotifier<JFileInfo> _audioList;

  //最大可录音数量
  final int _maxRecordCount;

  //最大录制时长
  final Duration _maxDuration;

  //录音进度管理
  final StreamController<AudioProgress> _positionController;

  //判断当前是否正在录音
  bool get isRecording => _audioState.value == AudioState.progressing;

  //判断当前是否正在暂停
  bool get isPause => _audioState.value == AudioState.pause;

  //判断当前是否停止
  bool get isStopped => _audioState.value == AudioState.stopped;

  //判断是否已达到最大录音数量
  bool get hasMaxCount => _audioList.length >= _maxRecordCount;

  //获取所有已录音文件
  List<JFileInfo> get audioFiles => _audioList.value;

  //移除已有文件记录
  void removeRecordFile(JFileInfo fileInfo) => _audioList.removeValue(fileInfo);

  JAudioRecordController({
    int maxRecordCount = 1,
    Duration maxDuration = const Duration(seconds: 60),
  })  : this._recorder = Record(),
        this._maxDuration = maxDuration,
        this._maxRecordCount = maxRecordCount,
        this._audioList = ListValueChangeNotifier.empty(),
        this._audioState = ValueChangeNotifier(AudioState.stopped),
        this._positionController = StreamController<AudioProgress>.broadcast();

  //获取录音器状态监听器
  ValueListenable<AudioState> get audioStateListenable => _audioState;

  //录音文件集合变化监听
  ValueListenable<List<JFileInfo>> get audioListListenable => _audioList;

  //录音进度
  Stream<AudioProgress> get onProgress => _positionController.stream;

  //启动录制
  Future<void> startRecord(
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
      _audioState.setValue(AudioState.progressing);
      _startTimer();
    }
  }

  //暂停录制
  Future<void> pauseRecord() async {
    if (isRecording) {
      await _recorder.pause();
      _audioState.setValue(AudioState.pause);
      _cancelTimer();
    }
  }

  //恢复录制
  Future<void> resumeRecord() async {
    if (isPause) {
      await _recorder.resume();
      _audioState.setValue(AudioState.progressing);
      _startTimer();
    }
  }

  //停止录制
  Future<String?> stopRecord() async {
    if (isStopped) return null;
    var result = await _recorder.stop();
    if (null != result) {
      _audioList.insertValue(0, [
        await JFileInfo.fromPath(result),
      ]);
    }
    _audioState.setValue(AudioState.stopped);
    _recordDuration = Duration.zero;
    _cancelTimer();
    _updateAudioProgress(_recordDuration, _maxDuration);
    return result;
  }

  //记录计时器id
  String _timerKey = "";

  //记录已录制时间
  Duration _recordDuration = Duration.zero;

  //启动计时器
  void _startTimer() {
    _timerKey = jTimer.countdown(
      maxDuration: _maxDuration.subtract(_recordDuration),
      callback: (remaining, passTime) {
        _recordDuration = passTime;
        _updateAudioProgress(_recordDuration, _maxDuration);
      },
      onFinish: () => stopRecord(),
    );
    _updateAudioProgress(_recordDuration, _maxDuration);
  }

  //更新进度
  void _updateAudioProgress(Duration position, Duration duration) =>
      _positionController.add(AudioProgress.from(
        position: position,
        duration: duration,
      ));

  //取消计时器
  void _cancelTimer() => jTimer.cancel(_timerKey);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _audioState.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    //销毁录音器
    _recorder.dispose();
    _audioList.clear();
    _cancelTimer();
  }
}
