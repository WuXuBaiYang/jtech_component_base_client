import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片视图框架
* @author wuxubaiyang
* @Time 2021/7/13 上午10:44
*/
class JImage extends BaseStatelessWidget {
  //图片资源管理
  final ImageDataSource dataSource;

  //配置文件信息
  final ImageConfig config;

  //点击事件
  final VoidCallback? imageTap;

  //长点击事件
  final VoidCallback? imageLongTap;

  JImage({
    required this.dataSource,
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    this.imageTap,
    this.imageLongTap,
  }) : this.config = (config ?? ImageConfig()).copyWith(
          width: size ?? width,
          height: size ?? height,
          fit: fit,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
        );

  //从fileInfo文件中家在
  JImage.fileInfo(
    JFileInfo fileInfo, {
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this(
          dataSource: ImageDataSource.fileInfo(fileInfo),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //本地图片文件路径
  JImage.filePath(
    String path, {
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this.file(
          File(path),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //本地图片文件
  JImage.file(
    File file, {
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this(
          dataSource: ImageDataSource.file(file),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //assets图片文件
  JImage.assets(
    String name, {
    AssetBundle? bundle,
    String? package,
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this(
          dataSource: ImageDataSource.assets(
            name,
            bundle: bundle,
            package: package,
          ),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //内存图片文件
  JImage.memory(
    Uint8List bytes, {
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this(
          dataSource: ImageDataSource.memory(bytes),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  //网络图片文件
  JImage.net(
    String imageUrl, {
    String? cacheKey,
    Map<String, String>? headers,
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    ImageClip? clip,
    ImageConfig? config,
    ImageEditorConfig? editorConfig,
    ImageGestureConfig? gestureConfig,
    VoidCallback? imageTap,
    VoidCallback? imageLongTap,
  }) : this(
          dataSource: ImageDataSource.net(
            imageUrl,
            cacheKey: cacheKey,
            headers: headers,
          ),
          width: width,
          height: height,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          clip: clip,
          size: size,
          fit: fit,
          config: config,
          editorConfig: editorConfig,
          gestureConfig: gestureConfig,
          imageTap: imageTap,
          imageLongTap: imageLongTap,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ExtendedImage(
        image: dataSource.image,
        width: config.width,
        height: config.height,
        fit: null != config.editorConfig ? BoxFit.contain : config.fit,
        alignment: config.alignment,
        repeat: config.repeat,
        color: config.color,
        colorBlendMode: config.colorBlendMode,
        mode: _imageMode,
        initEditorConfigHandler: (state) => EditorConfig(
          maxScale: config.editorConfig!.maxScale,
          cropRectPadding: config.editorConfig!.cropRectPadding,
          cornerSize: config.editorConfig!.cornerSize,
          cornerColor: config.editorConfig!.cornerColor,
          lineColor: config.editorConfig!.lineColor,
          lineHeight: config.editorConfig!.lineHeight,
          cropAspectRatio: config.editorConfig!.cropAspectRatio,
        ),
        extendedImageEditorKey: config.editorConfig?.controller?.editorKey,
        initGestureConfigHandler: (state) => GestureConfig(
          minScale: config.gestureConfig!.minScale,
          maxScale: config.gestureConfig!.maxScale,
          initialScale: config.gestureConfig!.initialScale,
          inPageView: config.gestureConfig!.inPageView,
        ),
        extendedImageGestureKey: config.gestureConfig?.controller?.gestureKey,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return (config.placeholderBuilder ?? _buildPlaceholder)(context);
            case LoadState.completed:
              return (config.imageBuilder ?? _buildImage)(
                  context, state.completedWidget);
            case LoadState.failed:
              return (config.errorBuilder ?? _buildError)(
                  context, state.lastException, state.lastStack);
          }
        },
        onDoubleTap: (state) {
          ///等待方法实现
          // var pointerDownPosition = state.pointerDownPosition;
          // var begin = state.gestureDetails?.totalScale;
          // state.handleDoubleTap(
          //     scale: _animation.value,
          //     doubleTapPosition: pointerDownPosition);
        },
      ),
      onTap: imageTap,
      onLongPress: imageLongTap,
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
  Widget _buildError(
      BuildContext context, Object? error, StackTrace? stackTrace) {
    return Container();
  }

  //获取图片模式
  get _imageMode {
    if (null != config.editorConfig) return ExtendedImageMode.editor;
    if (null != config.gestureConfig) return ExtendedImageMode.gesture;
    return ExtendedImageMode.none;
  }
}
