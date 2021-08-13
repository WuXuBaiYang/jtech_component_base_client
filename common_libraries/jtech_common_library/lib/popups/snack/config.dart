import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 自定义snack消息配置
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class SnackConfig extends BaseConfig {
  //snack内容
  Widget? content;

  //外间距
  EdgeInsets? margin;

  //内间距
  EdgeInsets? padding;

  //形状
  ShapeBorder? shape;

  //显示时长
  Duration duration;

  //事件文本
  String? actionLabel;

  //事件文本颜色
  Color? actionTextColor;

  //事件文本取消颜色
  Color? actionDisabledTextColor;

  //事件文本点击事件
  VoidCallback? onActionTap;

  //背景色
  Color? backgroundColor;

  //悬浮状态下的配置
  FloatingConfig? floatingConfig;

  SnackConfig({
    this.content,
    this.margin,
    this.padding,
    this.shape,
    this.duration = const Duration(seconds: 5),
    this.actionLabel,
    this.actionTextColor,
    this.actionDisabledTextColor,
    this.onActionTap,
    this.backgroundColor,
    this.floatingConfig,
  });

  @override
  SnackConfig copyWith({
    Widget? content,
    EdgeInsets? margin,
    EdgeInsets? padding,
    ShapeBorder? shape,
    Duration? duration,
    String? actionLabel,
    Color? actionTextColor,
    Color? actionDisabledTextColor,
    VoidCallback? onActionTap,
    Color? backgroundColor,
    FloatingConfig? floatingConfig,
  }) {
    return SnackConfig(
      content: content ?? this.content,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      duration: duration ?? this.duration,
      actionLabel: actionLabel ?? this.actionLabel,
      actionTextColor: actionTextColor ?? this.actionTextColor,
      actionDisabledTextColor:
          actionDisabledTextColor ?? this.actionDisabledTextColor,
      onActionTap: onActionTap ?? this.onActionTap,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      floatingConfig: floatingConfig ?? this.floatingConfig,
    );
  }
}

/*
* 悬浮状态配置
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class FloatingConfig extends BaseConfig {
  //悬浮高度
  double? elevation;

  //snack宽度
  double? width;

  FloatingConfig({
    this.elevation,
    this.width,
  });

  @override
  FloatingConfig copyWith({
    double? elevation,
    double? width,
  }) {
    return FloatingConfig(
      elevation: elevation ?? this.elevation,
      width: width ?? this.width,
    );
  }
}
