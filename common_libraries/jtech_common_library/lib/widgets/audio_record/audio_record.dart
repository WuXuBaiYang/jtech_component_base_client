import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/audio_record/config.dart';
import 'package:jtech_common_library/widgets/audio_record/controller.dart';

/*
* 音频录制组件
* @author wuxubaiyang
* @Time 2021/8/7 1:27
*/
class JAudioRecord extends BaseStatefulWidget {
  //控制器
  final JAudioRecordController controller;

  //配置对象
  final AudioRecordConfig config;

  JAudioRecord({
    required this.controller,
    Duration? maxDuration,
    AudioRecordConfig? config,
  }) : this.config = (config ?? AudioRecordConfig()).copyWith(
          maxDuration: maxDuration,
        );

  @override
  Widget build(BuildContext context) {
    return EmptyBox();
  }
}
