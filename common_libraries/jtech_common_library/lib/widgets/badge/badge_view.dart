import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';

/*
* 角标视图元素
* @author wuxubaiyang
* @Time 2021/7/12 上午10:29
*/
class JBadgeView extends BaseStatefulWidget {
  //自定义角标视图
  final Widget? child;

  //角标文本
  final String text;

  //角标文本样式
  final TextStyle textStyle;

  //角标背景颜色
  final Color backgroundColor;

  //角标背景圆角度数
  final double backgroundRadius;

  //角标背景是否为原型
  final bool backgroundCircle;

  //角标悬浮高度
  final double elevation;

  JBadgeView({
    this.child,
    this.text = "",
    double fontSize = 12,
    Color textColor = Colors.white,
    this.backgroundColor = Colors.red,
    this.backgroundRadius = 8,
    this.backgroundCircle = true,
    this.elevation = 8,
  }) : textStyle = TextStyle(fontSize: fontSize, color: textColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child ?? Text(text, style: textStyle),
      elevation: elevation,
      color: backgroundColor,
      shape: backgroundCircle
          ? CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(backgroundRadius),
              ),
            ),
    );
  }
}
