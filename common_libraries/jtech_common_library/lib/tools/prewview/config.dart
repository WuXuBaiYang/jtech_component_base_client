import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

//预览页面子项构造器
typedef PreviewItemBuilder = Widget? Function(
    BuildContext context, JFileInfo fileInfo, int index);

/*
* 预览配置对象
* @author jtechjh
* @Time 2021/8/23 10:39 上午
*/
class PreviewConfig extends BaseConfig {
  //是否显示标题栏
  bool showAppbar;

  //标题栏背景色
  Color? appbarColor;

  //返回按钮自定义样式
  Widget? backButton;

  //标题
  String title;

  //是否显示计数（拼接在标题后面）
  bool showCounter;

  //标题是否居中
  bool centerTitle;

  //预览子项构造器
  PreviewItemBuilder? itemBuilder;

  PreviewConfig({
    this.showAppbar = false,
    this.appbarColor,
    this.backButton,
    this.title = "",
    this.showCounter = true,
    this.centerTitle = true,
    this.itemBuilder,
  });

  @override
  PreviewConfig copyWith({
    bool? showAppbar,
    Color? appbarColor,
    Widget? backButton,
    String? title,
    bool? showCounter,
    bool? centerTitle,
    Color? color,
    bool? barrierDismissible,
    PreviewItemBuilder? itemBuilder,
  }) {
    return PreviewConfig(
      showAppbar: showAppbar ?? this.showAppbar,
      appbarColor: appbarColor ?? this.appbarColor,
      backButton: backButton ?? this.backButton,
      title: title ?? this.title,
      showCounter: showCounter ?? this.showCounter,
      centerTitle: centerTitle ?? this.centerTitle,
      itemBuilder: itemBuilder ?? this.itemBuilder,
    );
  }
}
