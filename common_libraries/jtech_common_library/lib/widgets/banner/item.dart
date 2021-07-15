import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/base/empty_box.dart';

/*
* banner数据对象
* @author wuxubaiyang
* @Time 2021/7/13 下午5:14
*/
class BannerItem {
  //子项内容
  WidgetBuilder builder;

  //子项背景颜色
  Color backgroundColor;

  //标题部分对象
  BannerItemTitle? title;

  BannerItem({
    required this.builder,
    this.backgroundColor = Colors.white,
    this.title,
  });
}

/*
* 子项标题部分对象
* @author wuxubaiyang
* @Time 2021/7/15 下午1:09
*/
class BannerItemTitle {
  //子项标题
  Widget child;

  //子项标题背景颜色
  Color backgroundColor;

  //子项标题内间距
  EdgeInsets padding;

  //子项标题外间距
  EdgeInsets margin;

  //子项标题位置
  TitleAlign align;

  BannerItemTitle({
    this.child = const EmptyBox(),
    this.backgroundColor = Colors.black38,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.margin = EdgeInsets.zero,
    this.align = TitleAlign.Bottom,
  });
}

/*
* 子项标题部分对齐方式
* @author wuxubaiyang
* @Time 2021/7/15 下午1:11
*/
enum TitleAlign {
  Top,
  Left,
  Right,
  Bottom,
}

/*
* 扩展对照alignment
* @author wuxubaiyang
* @Time 2021/7/15 下午1:17
*/
extension TitleAlignExtension on TitleAlign {
  //获取对齐方式
  Alignment get align {
    switch (this) {
      case TitleAlign.Top:
        return Alignment.topCenter;
      case TitleAlign.Left:
        return Alignment.centerLeft;
      case TitleAlign.Right:
        return Alignment.centerRight;
      case TitleAlign.Bottom:
        return Alignment.bottomCenter;
      default:
        return Alignment.bottomCenter;
    }
  }

  //判断是否为垂直方向
  bool get isVertical {
    switch (this) {
      case TitleAlign.Top:
      case TitleAlign.Bottom:
        return false;
      case TitleAlign.Left:
      case TitleAlign.Right:
        return true;
      default:
        return false;
    }
  }
}
