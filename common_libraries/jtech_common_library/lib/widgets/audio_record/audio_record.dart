import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/audio_record/controller.dart';

//录音结束回调
typedef OnRecordFinish = void Function(String path);

/*
* 音频录制组件
* @author wuxubaiyang
* @Time 2021/8/7 1:27
*/
class JAudioRecord extends BaseStatefulWidget {
  //控制器
  final JAudioRecordController controller;

  //录制结束回调
  final OnRecordFinish onRecordFinish;

  //最大可录制时长
  final Duration maxDuration;

  JAudioRecord({
    required this.onRecordFinish,
    JAudioRecordController? controller,
    this.maxDuration = const Duration(seconds: 60),
  }) : this.controller = controller ?? JAudioRecordController();

  @override
  Widget build(BuildContext context) {
    return EmptyBox();
  }
}
