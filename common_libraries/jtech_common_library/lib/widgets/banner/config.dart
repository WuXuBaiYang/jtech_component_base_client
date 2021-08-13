import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* banner数据对象
* @author wuxubaiyang
* @Time 2021/7/13 下午5:14
*/
class BannerItem extends BaseConfig {
  //子项内容
  WidgetBuilder builder;

  //子项背景颜色
  Color backgroundColor;

  //标题部分对象
  Widget? title;

  BannerItem({
    required this.builder,
    this.backgroundColor = Colors.white,
    this.title,
  });

  @override
  BannerItem copyWith({
    WidgetBuilder? builder,
    Color? backgroundColor,
    Widget? title,
  }) {
    return BannerItem(
      builder: builder ?? this.builder,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      title: title ?? this.title,
    );
  }
}

/*
* 子项对齐方式
* @author wuxubaiyang
* @Time 2021/7/15 下午1:11
*/
enum BannerAlign {
  top,
  left,
  right,
  bottom,
}

/*
* 扩展对照alignment
* @author wuxubaiyang
* @Time 2021/7/15 下午1:17
*/
extension BannerAlignExtension on BannerAlign {
  //获取对齐方式
  Alignment get align {
    switch (this) {
      case BannerAlign.top:
        return Alignment.topCenter;
      case BannerAlign.left:
        return Alignment.centerLeft;
      case BannerAlign.right:
        return Alignment.centerRight;
      case BannerAlign.bottom:
        return Alignment.bottomCenter;
      default:
        return Alignment.bottomCenter;
    }
  }

  //判断是否为垂直方向
  bool get isVertical {
    switch (this) {
      case BannerAlign.top:
      case BannerAlign.bottom:
        return false;
      case BannerAlign.left:
      case BannerAlign.right:
        return true;
      default:
        return false;
    }
  }
}
