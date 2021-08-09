import 'package:jtech_common_library/widgets/audio_record/controller.dart';

/*
* 音频录制组件配置文件
* @author jtechjh
* @Time 2021/8/9 2:24 下午
*/
class AudioRecordConfig {
  //最大可录制时长
  Duration maxDuration;

  AudioRecordConfig({
    this.maxDuration = const Duration(seconds: 60),
  });

  AudioRecordConfig copyWith({
    Duration? maxDuration,
  }) {
    return AudioRecordConfig(
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}
