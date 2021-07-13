import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:octo_image/octo_image.dart';

/*
* 图片视图框架
* @author wuxubaiyang
* @Time 2021/7/13 上午10:44
*/
class JImage extends BaseStatelessWidget {
  //图片对象代理
  final ImageProvider image;

  //配置文件信息
  final ImageConfig config;

  //本地图片文件路径
  JImage.filePath(
    String path, {
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
  }) : this.file(
          File(path),
          errorBuilder: errorBuilder,
          width: width,
          height: height,
          size: size,
          fit: fit,
          clip: clip,
          config: config,
        );

  //本地图片文件
  JImage.file(
    File file, {
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageConfig? config,
    ImageClip? clip,
  })  : image = FileImage(file),
        this.config = (config ?? ImageConfig()).copyWith(
          width: size ?? width,
          height: size ?? height,
          fit: fit,
          errorBuilder: errorBuilder,
          clip: clip,
        );

  //assets图片文件
  JImage.assets(
    String name, {
    AssetBundle? bundle,
    String? package,
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageConfig? config,
    ImageClip? clip,
  })  : image = AssetImage(name, bundle: bundle, package: package),
        this.config = (config ?? ImageConfig()).copyWith(
          width: size ?? width,
          height: size ?? height,
          fit: fit,
          errorBuilder: errorBuilder,
          clip: clip,
        );

  //内存图片文件
  JImage.memory(
    Uint8List bytes, {
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageConfig? config,
    ImageClip? clip,
  })  : image = MemoryImage(bytes),
        this.config = (config ?? ImageConfig()).copyWith(
          width: size ?? width,
          height: size ?? height,
          fit: fit,
          errorBuilder: errorBuilder,
          clip: clip,
        );

  //网络图片文件
  JImage.net(
    String imageUrl, {
    int? maxHeight,
    int? maxWidth,
    String? cacheKey,
    Map<String, String>? headers,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageConfig? config,
    ImageClip? clip,
  })  : image = CachedNetworkImageProvider(
          imageUrl,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          cacheKey: cacheKey,
          headers: headers,
        ),
        this.config = (config ?? ImageConfig()).copyWith(
          width: size ?? width,
          height: size ?? height,
          fit: fit,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          clip: clip,
        );

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: image,
      width: config.width,
      height: config.height,
      memCacheWidth: config.cacheWidth,
      memCacheHeight: config.cacheHeight,
      fit: config.fit,
      alignment: config.alignment,
      repeat: config.repeat,
      filterQuality: config.filterQuality,
      color: config.color,
      colorBlendMode: config.colorBlendMode,
      imageBuilder: config.imageBuilder ?? _buildImage,
      placeholderBuilder: config.placeholderBuilder ?? _buildPlaceholder,
      placeholderFadeInDuration: config.placeholderFadeInDuration,
      errorBuilder: config.errorBuilder ?? _buildErrorHolder,
      fadeInCurve: config.fadeInCurve,
      fadeInDuration: config.fadeInDuration,
      fadeOutCurve: config.fadeOutCurve,
      fadeOutDuration: config.fadeOutDuration,
    );
  }

  //构建默认的图片构建事件
  Widget _buildImage(BuildContext context, Widget child) {
    return config.clip?.clip(context, child) ?? child;
  }

  //构建默认的占位图
  Widget _buildPlaceholder(BuildContext context) {
    return Container();
  }

  //构建默认的异常占位图
  Widget _buildErrorHolder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    return Container();
  }
}

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
