import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:jtech_common_library/base/controller.dart';

/*
* 音频录制组件控制器
* @author jtechjh
* @Time 2021/8/9 2:24 下午
*/
class JAudioRecordController extends BaseController {
  //音频录制控制器
  final FlutterSoundRecorder _recorder;

  JAudioRecordController() : this._recorder = FlutterSoundRecorder();

  //启动录制
  Future<void> startRecord({
    String? toFile,
    int sampleRate = 16000,
    int numChannels = 1,
    int bitRate = 16000,
  }) async {
    await _recorder.openAudioSession();
    await _recorder.startRecorder(
      toFile: toFile,
      sampleRate: sampleRate,
      numChannels: numChannels,
      bitRate: bitRate,
    );
  }

  //暂停录制
  Future<void> pauseRecord() async {
    return _recorder.pauseRecorder();
  }

  //恢复录制
  Future<void> resumeRecord() async {
    return _recorder.resumeRecorder();
  }

  //停止录制
  Future<String?> stopRecord() async {
    return _recorder.stopRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    //销毁录音控制器
    _recorder.closeAudioSession();
  }
}
