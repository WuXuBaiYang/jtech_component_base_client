import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'config.dart';

/*
* snack消息
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class JSnack extends BaseManage {
  static final JSnack _instance = JSnack._internal();

  factory JSnack() => _instance;

  JSnack._internal();

  @override
  Future<void> init() async {}

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
      behavior: null != config.floatingConfig
          ? SnackBarBehavior.floating
          : SnackBarBehavior.fixed,
      action: _getAction(config),
      elevation: config.floatingConfig?.elevation,
      width: config.floatingConfig?.width,
    ));
  }

  //获取动作事件
  SnackBarAction? _getAction(SnackConfig config) {
    if (null == config.actionLabel || null == config.onActionTap) return null;
    return SnackBarAction(
      label: config.actionLabel!,
      onPressed: config.onActionTap!,
      textColor: config.actionTextColor,
      disabledTextColor: config.actionDisabledTextColor,
    );
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

//单例调用
final jSnack = JSnack();
