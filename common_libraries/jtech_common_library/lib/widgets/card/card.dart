import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/base/empty_box.dart';

/*
* 卡片视图
* @author wuxubaiyang
* @Time 2021/7/19 下午1:55
*/
class JCard extends StatelessWidget {
  //卡片子视图
  final Widget child;

  //卡片子视图集合
  final List<Widget> children;

  //外间距
  final EdgeInsetsGeometry margin;

  //内间距
  final EdgeInsetsGeometry padding;

  //形状
  final ShapeBorder shape;

  //背景色
  final Color color;

  //悬浮高度
  final double elevation;

  //卡片裁剪方式
  final Clip? clipBehavior;

  //阴影颜色
  final Color? shadowColor;

  //卡片容器布局
  final CardLayout layout;

  //主方向对齐方式
  final MainAxisAlignment mainAxisAlignment;

  //主方向尺寸
  final MainAxisSize mainAxisSize;

  //次方向对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  //创建垂直结构的卡片式图
  JCard.column({
    required this.children,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(15),
    ShapeBorder? shape,
    bool circle = false,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.white,
    this.elevation = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.clipBehavior,
    this.shadowColor,
  })  : this.layout = CardLayout.Column,
        this.shape = shape ?? _buildCardShapeBorder(circle, borderRadius),
        this.child = EmptyBox();

  //创建水平结构的卡片式图
  JCard.row({
    required this.children,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(15),
    ShapeBorder? shape,
    bool circle = false,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.white,
    this.elevation = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.clipBehavior,
    this.shadowColor,
  })  : this.layout = CardLayout.Row,
        this.shape = shape ?? _buildCardShapeBorder(circle, borderRadius),
        this.child = EmptyBox();

  //单元素卡片视图
  JCard.single({
    required this.child,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(15),
    ShapeBorder? shape,
    bool circle = false,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.white,
    this.elevation = 8.0,
    this.clipBehavior,
    this.shadowColor,
  })  : this.layout = CardLayout.None,
        this.shape = shape ?? _buildCardShapeBorder(circle, borderRadius),
        this.children = const [],
        this.mainAxisAlignment = MainAxisAlignment.start,
        this.mainAxisSize = MainAxisSize.min,
        this.crossAxisAlignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: clipBehavior,
      shadowColor: shadowColor,
      elevation: elevation,
      margin: margin,
      color: color,
      shape: shape,
      child: Container(
        padding: padding,
        child: _buildCardLayout(),
      ),
    );
  }

  //构建卡片布局
  Widget _buildCardLayout() {
    switch (layout) {
      case CardLayout.Column:
      case CardLayout.Row:
        var direction =
            layout == CardLayout.Column ? Axis.vertical : Axis.horizontal;
        return Flex(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          direction: direction,
          children: children,
        );
      case CardLayout.None:
      default:
        return child;
    }
  }

  //创建卡片组件形状边框
  static ShapeBorder _buildCardShapeBorder(
      bool circle, BorderRadiusGeometry borderRadius) {
    if (circle) return CircleBorder();
    return RoundedRectangleBorder(borderRadius: borderRadius);
  }
}

/*
* 卡片视图容器类型
* @author wuxubaiyang
* @Time 2021/7/19 下午2:01
*/
enum CardLayout {
  Column,
  Row,
  None,
}
