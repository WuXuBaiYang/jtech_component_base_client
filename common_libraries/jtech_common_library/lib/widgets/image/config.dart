import 'package:flutter/widgets.dart';

import 'clip.dart';

//图片加载构造器
typedef ImageBuilder = Widget Function(BuildContext context, Widget child);
//图片占位构造器
typedef PlaceholderBuilder = Widget Function(BuildContext context);
//图片异常占位构造器
typedef ErrorBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

/*
* 图片加载配置文件
* @author wuxubaiyang
* @Time 2021/7/13 下午1:49
*/
class ImageConfig {
  //图片构造器
  ImageBuilder? imageBuilder;

  //占位格构柱奥奇
  PlaceholderBuilder? placeholderBuilder;

  //异常构造器
  ErrorBuilder? errorBuilder;

  //占位图渐入时间
  Duration placeholderFadeInDuration;

  //渐出时间
  Duration fadeOutDuration;

  //渐出动画
  Curve fadeOutCurve;

  //渐入时间
  Duration fadeInDuration;

  //渐入动画
  Curve fadeInCurve;

  //宽度
  double? width;

  //高度
  double? height;

  //填充方式
  BoxFit? fit;

  //对齐方式
  Alignment alignment;

  //图片重复方式
  ImageRepeat repeat;

  //调色
  Color? color;

  //调色模式
  BlendMode? colorBlendMode;

  //绘制清晰度
  FilterQuality filterQuality;

  //缓存宽度
  int? cacheWidth;

  //缓存高度
  int? cacheHeight;

  //图片裁剪方法
  ImageClip? clip;

  ImageConfig({
    this.imageBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.placeholderFadeInDuration = Duration.zero,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.cacheWidth,
    this.cacheHeight,
    this.clip,
  });

  ImageConfig copyWith({
    ImageBuilder? imageBuilder,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    Duration? placeholderFadeInDuration,
    Duration? fadeOutDuration,
    Curve? fadeOutCurve,
    Duration? fadeInDuration,
    Curve? fadeInCurve,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment? alignment,
    ImageRepeat? repeat,
    Color? color,
    BlendMode? colorBlendMode,
    FilterQuality? filterQuality,
    int? cacheWidth,
    int? cacheHeight,
    ImageClip? clip,
  }) {
    return ImageConfig(
      imageBuilder: imageBuilder ?? this.imageBuilder,
      placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      placeholderFadeInDuration:
          placeholderFadeInDuration ?? this.placeholderFadeInDuration,
      fadeOutDuration: fadeOutDuration ?? this.fadeOutDuration,
      fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
      fadeInDuration: fadeInDuration ?? this.fadeInDuration,
      fadeInCurve: fadeInCurve ?? this.fadeInCurve,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      alignment: alignment ?? this.alignment,
      repeat: repeat ?? this.repeat,
      color: color ?? this.color,
      colorBlendMode: colorBlendMode ?? this.colorBlendMode,
      filterQuality: filterQuality ?? this.filterQuality,
      cacheWidth: cacheWidth ?? this.cacheWidth,
      cacheHeight: cacheHeight ?? this.cacheHeight,
      clip: clip ?? this.clip,
    );
  }
}
