import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

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
  BaseState<BaseStatefulWidget> getState() => _JAudioRecordState();
}

/*
* 音频录制组件状态
* @author jtechjh
* @Time 2021/8/13 10:53 上午
*/
class _JAudioRecordState extends BaseState<JAudioRecord> {
  @override
  Widget build(BuildContext context) {
    return EmptyBox();
  }
}
