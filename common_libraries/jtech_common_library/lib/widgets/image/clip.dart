import 'package:flutter/widgets.dart';

/*
* 图片裁剪方法基类
* @author wuxubaiyang
* @Time 2021/7/13 下午4:01
*/
abstract class ImageClip {
  //裁剪方法
  @protected
  Widget clip(BuildContext context, Widget child);
}

/*
* 圆形图片裁剪
* @author wuxubaiyang
* @Time 2021/7/13 下午4:02
*/
class ImageClipOval extends ImageClip {
  //自定义裁剪方法
  final CustomClipper<Rect>? clipper;

  //裁剪方法
  final Clip clipBehavior;

  ImageClipOval({
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget clip(BuildContext context, Widget child) {
    return ClipOval(
      child: child,
      clipper: clipper,
      clipBehavior: clipBehavior,
    );
  }
}

/*
* 圆角图片裁剪
* @author wuxubaiyang
* @Time 2021/7/13 下午4:05
*/
class ImageClipRRect extends ImageClip {
  //圆角控制
  final BorderRadius borderRadius;

  //自定义裁剪方法
  final CustomClipper<RRect>? clipper;

  //裁剪方法
  final Clip clipBehavior;

  ImageClipRRect({
    required this.borderRadius,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget clip(BuildContext context, Widget child) {
    return ClipRRect(
      child: child,
      borderRadius: borderRadius,
      clipper: clipper,
      clipBehavior: clipBehavior,
    );
  }
}
