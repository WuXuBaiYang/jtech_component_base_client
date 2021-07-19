import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:octo_image/octo_image.dart';

import 'clip.dart';
import 'config.dart';

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

  //点击事件
  final VoidCallback? imageTap;

  //长点击事件
  final VoidCallback? imageLongTap;

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
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this.file(
          File(path),
          errorBuilder: errorBuilder,
          width: width,
          height: height,
          size: size,
          fit: fit,
          clip: clip,
          config: config,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //本地图片文件
  JImage.file(
    File file, {
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    this.imageTap,
    this.imageLongTap,
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
    ImageClip? clip,
    ImageConfig? config,
    this.imageTap,
    this.imageLongTap,
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
    ImageClip? clip,
    ImageConfig? config,
    this.imageTap,
    this.imageLongTap,
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
    ImageClip? clip,
    ImageConfig? config,
    this.imageTap,
    this.imageLongTap,
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
    return GestureDetector(
      child: OctoImage(
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
      ),
      onTap: null != imageTap
          ? () {
              Feedback.forTap(context);
              imageTap!();
            }
          : null,
      onLongPress: null != imageLongTap
          ? () {
              Feedback.forLongPress(context);
              imageLongTap!();
            }
          : null,
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
