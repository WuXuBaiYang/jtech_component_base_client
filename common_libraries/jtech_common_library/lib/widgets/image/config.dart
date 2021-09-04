import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'clip.dart';

//图片加载构造器
typedef ImageBuilder = Widget Function(BuildContext context, Widget child);

//图片占位构造器
typedef PlaceholderBuilder = Widget Function(BuildContext context);

//图片异常占位构造器
typedef ErrorBuilder = Widget Function(
    BuildContext context, Object? error, StackTrace? stackTrace);

/*
* 图片加载配置文件
* @author wuxubaiyang
* @Time 2021/7/13 下午1:49
*/
class ImageConfig extends BaseConfig {
  //图片构造器
  ImageBuilder? imageBuilder;

  //占位图构造器
  PlaceholderBuilder? placeholderBuilder;

  //异常构造器
  ErrorBuilder? errorBuilder;

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

  //图片裁剪方法
  ImageClip? clip;

  //编辑管理配置，非空则启用
  ImageEditorConfig? editorConfig;

  //手势控制配置，非空则启用
  ImageGestureConfig? gestureConfig;

  ImageConfig({
    this.imageBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.clip,
    this.editorConfig,
    this.gestureConfig,
  });

  @override
  ImageConfig copyWith({
    ImageBuilder? imageBuilder,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment? alignment,
    ImageRepeat? repeat,
    Color? color,
    BlendMode? colorBlendMode,
    FilterQuality? filterQuality,
    ImageClip? clip,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
  }) {
    return ImageConfig(
      imageBuilder: imageBuilder ?? this.imageBuilder,
      placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      alignment: alignment ?? this.alignment,
      repeat: repeat ?? this.repeat,
      color: color ?? this.color,
      colorBlendMode: colorBlendMode ?? this.colorBlendMode,
      filterQuality: filterQuality ?? this.filterQuality,
      clip: clip ?? this.clip,
      editorConfig: editorConfig ?? this.editorConfig,
      gestureConfig: gestureConfig ?? this.gestureConfig,
    );
  }
}

/*
* 图片编辑配置参数
* @author jtechjh
* @Time 2021/9/3 2:26 下午
*/
class ImageEditorConfig extends BaseConfig {
  //编辑控制器
  final ImageEditorController? controller;

  //最大缩放比例
  final double maxScale;

  //裁剪框内间距
  final EdgeInsets cropRectPadding;

  //角尺寸
  final Size cornerSize;

  //角颜色
  final Color? cornerColor;

  //格子线颜色
  final Color? lineColor;

  //格子线高度
  final double lineHeight;

  //裁剪比例,null为自由比例
  //其他比例设置方式例如 9:16 = 9.0/16.0
  final double? cropAspectRatio;

  ImageEditorConfig({
    this.controller,
    this.maxScale = 3.0,
    this.cropRectPadding = const EdgeInsets.all(15),
    this.cornerSize = const Size(30, 5),
    this.cornerColor,
    this.lineColor,
    this.lineHeight = 0.5,
    this.cropAspectRatio,
  });

  @override
  ImageEditorConfig copyWith({
    ImageEditorController? controller,
    double? maxScale,
    EdgeInsets? cropRectPadding,
    Size? cornerSize,
    Color? cornerColor,
    Color? lineColor,
    double? lineHeight,
    double? cropAspectRatio,
  }) {
    return ImageEditorConfig(
      controller: controller ?? this.controller,
      maxScale: maxScale ?? this.maxScale,
      cropRectPadding: cropRectPadding ?? this.cropRectPadding,
      cornerSize: cornerSize ?? this.cornerSize,
      cornerColor: cornerColor ?? this.cornerColor,
      lineColor: lineColor ?? this.lineColor,
      lineHeight: lineHeight ?? this.lineHeight,
      cropAspectRatio: cropAspectRatio ?? this.cropAspectRatio,
    );
  }
}

/*
* 图片手势控制配置参数
* @author jtechjh
* @Time 2021/9/3 2:26 下午
*/
class ImageGestureConfig extends BaseConfig {
  //手势控制器
  final ImageGestureController? controller;

  //最小缩放比例
  final double minScale;

  //最大缩放比例
  final double maxScale;

  //默认缩放比例
  final double initialScale;

  //判断是否在pageView组件中
  final bool inPageView;

  ImageGestureConfig({
    this.controller,
    this.minScale = 0.6,
    this.maxScale = 3.0,
    this.initialScale = 1.0,
    this.inPageView = false,
  });

  @override
  ImageGestureConfig copyWith({
    ImageGestureController? controller,
    double? minScale,
    double? maxScale,
    double? initialScale,
    bool? inPageView,
  }) {
    return ImageGestureConfig(
      controller: controller ?? this.controller,
      minScale: minScale ?? this.minScale,
      maxScale: maxScale ?? this.maxScale,
      initialScale: initialScale ?? this.initialScale,
      inPageView: inPageView ?? this.inPageView,
    );
  }
}

/*
* 图片数据源管理
* @author jtechjh
* @Time 2021/9/4 10:27 上午
*/
class ImageDataSource {
  //图片对象代理
  final ImageProvider image;

  ImageDataSource(this.image);

  //从jFileInfo中自动判断类型
  ImageDataSource.fileInfo(
    JFileInfo fileInfo, {
    String? cacheKey,
    Map<String, String>? headers,
    bool cacheRawData = false,
  }) : this(fileInfo.isNetFile
            ? ExtendedNetworkImageProvider(
                fileInfo.uri,
                cacheKey: cacheKey,
                headers: headers,
                cacheRawData: cacheRawData,
              )
            : ExtendedFileImageProvider(
                fileInfo.file,
                cacheRawData: cacheRawData,
              ) as ImageProvider);

  //文件加载
  ImageDataSource.file(
    File file, {
    bool cacheRawData = false,
  }) : this(ExtendedFileImageProvider(
          file,
          cacheRawData: cacheRawData,
        ));

  //文件路径加载
  ImageDataSource.filePath(
    String filePath, {
    bool cacheRawData = false,
  }) : this.file(
          File(filePath),
          cacheRawData: cacheRawData,
        );

  //assets资源
  ImageDataSource.assets(
    String name, {
    AssetBundle? bundle,
    String? package,
    bool cacheRawData = false,
  }) : this(ExtendedAssetImageProvider(
          name,
          bundle: bundle,
          package: package,
          cacheRawData: cacheRawData,
        ));

  //内存资源
  ImageDataSource.memory(
    Uint8List bytes, {
    bool cacheRawData = false,
  }) : this(ExtendedMemoryImageProvider(
          bytes,
          cacheRawData: cacheRawData,
        ));

  //网络图片
  ImageDataSource.net(
    String imageUrl, {
    String? cacheKey,
    Map<String, String>? headers,
    bool cacheRawData = false,
  }) : this(ExtendedNetworkImageProvider(
          imageUrl,
          cacheKey: cacheKey,
          headers: headers,
          cacheRawData: cacheRawData,
        ));
}
