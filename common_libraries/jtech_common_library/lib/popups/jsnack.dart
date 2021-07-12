import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

/*
* snack消息
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class JSnack {
  //显示基础snack提示
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
      BuildContext context,
      {required SnackConfig config}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: config.content ?? EmptyBox(),
      margin: config.margin,
      padding: config.padding,
      shape: config.shape,
      duration: config.duration,
      backgroundColor: config.backgroundColor,
      behavior: config.behavior,
      action: config.action,
      elevation: config.floatingConfig?.elevation,
      width: config.floatingConfig?.width,
    ));
  }

  //显示一定时间内的snack
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackInTime(
    BuildContext context, {
    required String text,
    Widget? content,
    Duration duration = const Duration(seconds: 4),
    Color? textColor,
    double? fontSize,
    String? actionLabel,
    VoidCallback? onActionTap,
    SnackConfig? config,
  }) {
    return showSnack(
      context,
      config: (config ?? SnackConfig()).copyWith(
        duration: duration,
        content: content ??
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
        actionLabel: actionLabel,
        onActionTap: onActionTap,
      ),
    );
  }

  //展示常驻snack提示
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showConstSnack(
    BuildContext context, {
    required String text,
    Widget? content,
    Color? textColor,
    double? fontSize,
    String? actionLabel,
    VoidCallback? onActionTap,
    SnackConfig? config,
  }) {
    return showSnackInTime(
      context,
      content: content,
      duration: const Duration(days: 1),
      text: text,
      textColor: textColor,
      fontSize: fontSize,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
      config: config,
    );
  }
}

/*
* 自定义snack消息配置
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class SnackConfig {
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

  //获取当前behavior状态
  @protected
  SnackBarBehavior get behavior => null != floatingConfig
      ? SnackBarBehavior.floating
      : SnackBarBehavior.fixed;

  //获取事件对象
  @protected
  SnackBarAction? get action {
    if (null == actionLabel || null == onActionTap) return null;
    return SnackBarAction(
      label: actionLabel!,
      onPressed: onActionTap!,
      textColor: actionTextColor,
      disabledTextColor: actionDisabledTextColor,
    );
  }
}

/*
* 悬浮状态配置
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class FloatingConfig {
  //悬浮高度
  double? elevation;

  //snack宽度
  double? width;

  FloatingConfig({
    this.elevation,
    this.width,
  });
}
