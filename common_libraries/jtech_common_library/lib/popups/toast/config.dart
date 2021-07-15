import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

//toast构建器
typedef ToastBuilder = Widget Function(BuildContext context, Widget? child);

/*
* toast配置信息
* @author wuxubaiyang
* @Time 2021/7/9 下午5:20
*/
class ToastConfig {
  //toast内容子项
  Widget? child;

  //构建toast背景视图
  ToastBuilder? toastBuilder;

  //toast时间
  Duration? duration;

  //toast位置
  Alignment? align;

  //默认toast内间距
  EdgeInsets padding;

  //默认toast容器样式
  BoxDecoration decoration;

  ToastConfig({
    this.toastBuilder,
    this.duration,
    this.align,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
    Color backgroundColor = Colors.black38,
    BorderRadiusGeometry borderRadius =
    const BorderRadius.all(Radius.circular(100)),
  }) : decoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: borderRadius,
  );

  ToastConfig copyWith({
    ToastBuilder? toastBuilder,
    Duration? duration,
    Alignment? align,
    Widget? child,
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return ToastConfig(
      toastBuilder: toastBuilder ?? this.toastBuilder,
      duration: duration ?? this.duration,
      align: align ?? this.align,
      child: child ?? this.child,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.decoration.color!,
      borderRadius: borderRadius ?? this.decoration.borderRadius!,
    );
  }

  //将align转换为toastGravity
  @protected
  ToastGravity get gravity => _alignGravity[align] ?? ToastGravity.BOTTOM;
}

//位置与重力转换表
final Map<Alignment, ToastGravity> _alignGravity = {
  Alignment.topCenter: ToastGravity.TOP,
  Alignment.topLeft: ToastGravity.TOP_LEFT,
  Alignment.topRight: ToastGravity.TOP_RIGHT,
  Alignment.center: ToastGravity.CENTER,
  Alignment.centerLeft: ToastGravity.CENTER_LEFT,
  Alignment.centerRight: ToastGravity.CENTER_RIGHT,
  Alignment.bottomCenter: ToastGravity.BOTTOM,
  Alignment.bottomLeft: ToastGravity.BOTTOM_LEFT,
  Alignment.bottomRight: ToastGravity.BOTTOM_RIGHT,
};