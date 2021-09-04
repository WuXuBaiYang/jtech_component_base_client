import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 角标配置
* @author wuxubaiyang
* @Time 2021/7/16 下午2:40
*/
class BadgeConfig extends BaseConfig {
  //自定义角标视图
  final Widget? child;

  //角标宽度
  final double width;

  //角标高度
  final double height;

  //角标文本
  final String text;

  //角标文本样式
  final TextStyle textStyle;

  //角标背景颜色
  final Color color;

  //角标背景圆角度数
  final double radius;

  //角标背景是否为原型
  final bool circle;

  //外间距
  final EdgeInsets margin;

  //内间距
  final EdgeInsets padding;

  //角标悬浮高度
  final double elevation;

  //构建空的角标配置
  static final BadgeConfig empty = BadgeConfig();

  BadgeConfig({
    this.child,
    this.text = "",
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(6),
    double? width,
    double? height,
    double size = 30,
    double fontSize = 8,
    Color textColor = Colors.white,
    this.color = Colors.red,
    this.radius = -1,
    this.elevation = 2,
  })  : textStyle = TextStyle(fontSize: fontSize, color: textColor),
        this.width = width ?? size,
        this.height = height ?? size,
        circle = radius < 0;

  @override
  BadgeConfig copyWith({
    Widget? child,
    double? width,
    double? height,
    String? text,
    Color? color,
    double? radius,
    bool? circle,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? elevation,
    BadgeConfig? empty,
  }) {
    return BadgeConfig(
      child: child ?? this.child,
      width: width ?? this.width,
      height: height ?? this.height,
      text: text ?? this.text,
      color: color ?? this.color,
      radius: radius ?? this.radius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
    );
  }
}
