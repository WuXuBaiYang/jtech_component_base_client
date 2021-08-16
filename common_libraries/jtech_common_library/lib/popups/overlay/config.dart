import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 弹层配置对象
* @author jtechjh
* @Time 2021/8/16 11:38 上午
*/
class OverlayConfig extends BaseConfig {
  //弹层尺寸
  Size size;

  //弹层内容位置
  Rect rect;

  //与目标点位的间距
  double targetSpace;

  OverlayConfig({
    this.size = Size.zero,
    this.rect = Rect.zero,
    this.targetSpace = 6,
  });

  @override
  OverlayConfig copyWith({
    Size? size,
    Rect? rect,
    double? targetSpace,
  }) {
    return OverlayConfig(
      size: size ?? this.size,
      rect: rect ?? this.rect,
      targetSpace: targetSpace ?? this.targetSpace,
    );
  }

  //获取实际位置偏移量
  Offset getOffset(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double dx = rect.left + rect.width / 2.0 - size.width / 2.0;
    if (dx < 10) dx = 10;
    if (dx + size.width > screenSize.width && dx > 10) {
      double tempDx = screenSize.width - size.width - 10;
      if (tempDx > 10) dx = tempDx;
    }

    var paddingTop = MediaQuery.of(context).padding.top;
    double dy = rect.top - size.height;
    if (dy <= paddingTop + targetSpace) {
      dy = targetSpace + rect.height + rect.top;
    } else {
      dy -= targetSpace;
    }
    return Offset(dx, dy);
  }
}
