import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

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

  //背景色
  Color color;

  //点击空白处是否关闭预览
  bool barrierDismissible;

  PreviewConfig({
    this.showAppbar = false,
    this.appbarColor,
    this.backButton,
    this.title = "",
    this.showCounter = true,
    this.centerTitle = true,
    this.color = Colors.black38,
    this.barrierDismissible = true,
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
  }) {
    return PreviewConfig(
      showAppbar: showAppbar ?? this.showAppbar,
      appbarColor: appbarColor ?? this.appbarColor,
      backButton: backButton ?? this.backButton,
      title: title ?? this.title,
      showCounter: showCounter ?? this.showCounter,
      centerTitle: centerTitle ?? this.centerTitle,
      color: color ?? this.color,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
    );
  }
}
