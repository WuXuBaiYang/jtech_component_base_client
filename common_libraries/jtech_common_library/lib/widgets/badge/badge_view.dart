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

  JBadgeView({
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
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height),
      child: Card(
        child: Center(
          child: Padding(
            padding: padding,
            child: child ?? Text(text, style: textStyle),
          ),
        ),
        elevation: elevation,
        color: color,
        shape: circle
            ? CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
              ),
      ),
    );
  }
}
