import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频录制组件
* @author wuxubaiyang
* @Time 2021/8/7 1:27
*/
class JAudioRecord extends BaseStatefulWidgetMultiply {
  //控制器
  final JAudioRecordController controller;

  //配置对象
  final AudioRecordConfig config;

  JAudioRecord({
    required BaseJAudioRecordState currentState,
    required this.controller,
    required this.config,
  }) : super(currentState: currentState);

  //构建完整版录音器组件
  static JAudioRecord full({
    //基本录音器参数
    JAudioRecordController? controller,
    AudioRecordConfig? config,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Duration? maxDuration,
    OnRecordFinish? onRecordFinish,
    //完整版录音器参数
    FullAudioRecordConfig? fullConfig,
  }) {
    return JAudioRecord(
      controller: controller ?? JAudioRecordController(),
      currentState: JAudioRecordFullState(
        config: (fullConfig ?? FullAudioRecordConfig()).copyWith(),
      ),
      config: (config ?? AudioRecordConfig()).copyWith(
        margin: margin,
        padding: padding,
        elevation: elevation,
        maxDuration: maxDuration,
        onRecordFinish: onRecordFinish,
      ),
    );
  }

  //构建简易版录音器组件
  static JAudioRecord simple({
    //基本录音器参数
    JAudioRecordController? controller,
    AudioRecordConfig? config,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Duration? maxDuration,
    OnRecordFinish? onRecordFinish,
  }) {
    return JAudioRecord(
      controller: controller ?? JAudioRecordController(),
      currentState: JAudioRecordSimpleState(),
      config: (config ?? AudioRecordConfig()).copyWith(
        margin: margin,
        padding: padding,
        elevation: elevation,
        maxDuration: maxDuration,
        onRecordFinish: onRecordFinish,
      ),
    );
  }
}

/*
* 音频录制组件状态基类
* @author jtechjh
* @Time 2021/8/13 10:53 上午
*/
abstract class BaseJAudioRecordState extends BaseState<JAudioRecord> {
  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
  }
}
