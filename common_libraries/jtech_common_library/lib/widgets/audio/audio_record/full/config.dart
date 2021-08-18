import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 完整版录音器组件配置对象
* @author jtechjh
* @Time 2021/8/17 10:19 上午
*/
class FullAudioRecordConfig extends BaseConfig {
  //标题部分组件
  Widget? title;

  //标题部分内间距
  EdgeInsetsGeometry titlePadding;

  FullAudioRecordConfig({
    this.title,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  FullAudioRecordConfig copyWith({
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
  }) {
    return FullAudioRecordConfig(
      title: title ?? this.title,
      titlePadding: titlePadding ?? this.titlePadding,
    );
  }
}
