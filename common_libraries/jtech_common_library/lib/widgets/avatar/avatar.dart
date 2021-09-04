import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

//头像点击事件
typedef OnAvatarChange = void Function(ImageDataSource dataSource);

/*
* 头像组件
* @author wuxubaiyang
* @Time 2021/7/26 上午10:53
*/
class JAvatar extends BaseStatelessWidget {
  //头像点击事件
  final OnAvatarChange? onTap;

  //头像更新事件
  final OnAvatarChange? onChange;

  //背景色
  final Color color;

  //悬浮高度
  final double elevation;

  //占位图
  final ErrorBuilder? errorBuilder;

  //占位图构造器
  final PlaceholderBuilder? placeholderBuilder;

  //头像尺寸（1：1）
  final double size;

  //判断是否为圆形头像
  final bool circle;

  //为矩形时的圆角度数
  final BorderRadius borderRadius;

  //内间距
  final EdgeInsets padding;

  //外间距
  final EdgeInsets margin;

  //头像组件控制器
  final JAvatarController controller;

  JAvatar({
    required this.controller,
    this.onTap,
    this.onChange,
    this.color = Colors.white,
    this.elevation = 0.0,
    this.placeholderBuilder,
    this.errorBuilder,
    this.size = 45,
    this.circle = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  //矩形头像
  JAvatar.square({
    required ImageDataSource dataSource,
    OnAvatarUpload? onAvatarUpload,
    OnAvatarChange? onTap,
    OnAvatarChange? onChange,
    Color color = Colors.white,
    double elevation = 0.0,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double size = 45,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this(
          controller: JAvatarController.withMenu(
            dataSource: dataSource,
            onAvatarUpload: onAvatarUpload,
            pickImage: pickImage,
            takePhoto: takePhoto,
          ),
          onTap: onTap,
          onChange: onChange,
          color: color,
          elevation: elevation,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          size: size,
          borderRadius: borderRadius,
          margin: margin,
          padding: padding,
          circle: false,
        );

  //圆形头像
  JAvatar.circle({
    required ImageDataSource dataSource,
    OnAvatarUpload? onAvatarUpload,
    OnAvatarChange? onTap,
    OnAvatarChange? onChange,
    Color color = Colors.white,
    double elevation = 0.0,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double size = 45,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this(
          controller: JAvatarController.withMenu(
            dataSource: dataSource,
            onAvatarUpload: onAvatarUpload,
            pickImage: pickImage,
            takePhoto: takePhoto,
          ),
          onTap: onTap,
          onChange: onChange,
          color: color,
          elevation: elevation,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          size: size,
          borderRadius: borderRadius,
          margin: margin,
          padding: padding,
          circle: true,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: JCard.single(
        child: _buildAvatar(context),
        borderRadius: borderRadius,
        elevation: elevation,
        padding: padding,
        margin: margin,
        circle: circle,
        color: color,
      ),
      onTap: () {
        onTap?.call(controller.dataSource);
        controller.pickAvatar(context).then((value) {
          if (null != value) onChange?.call(value);
        });
      },
    );
  }

  //构建头像
  Widget _buildAvatar(BuildContext context) {
    return ValueListenableBuilder<ImageDataSource>(
      valueListenable: controller.dataSourceListenable,
      builder: (context, value, child) {
        return JImage(
          size: size,
          fit: BoxFit.fill,
          dataSource: value,
          clip: circle
              ? ImageClipOval()
              : ImageClipRRect(borderRadius: borderRadius),
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
        );
      },
    );
  }
}
