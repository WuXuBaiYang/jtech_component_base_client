import 'dart:async';

import 'package:jtech_common_library/jcommon.dart';

/*
* 音频录制组件控制器
* @author jtechjh
* @Time 2021/8/9 2:24 下午
*/
class JAudioRecordController extends BaseController {
  //启动录制
  Future<void> startRecord({
    String? toFile,
  }) async {}

  //暂停录制
  Future<void> pauseRecord() async {
    // return _recorder.pauseRecorder();
  }

  //恢复录制
  Future<void> resumeRecord() async {}

  //停止录制
  Future<void> stopRecord() async {}

  @override
  void dispose() {
    super.dispose();
  }
}
