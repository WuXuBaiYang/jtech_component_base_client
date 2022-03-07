import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单头像子项
* @author wuxubaiyang
* @Time 2021/7/26 上午10:50
*/
class JFormAvatarItemState extends BaseJFormItemState<ImageDataSource> {
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

  //头像组件控制器
  final JAvatarController controller;

  //点击范围，是否整个item点击触发
  final bool clickFullArea;

  //开关对齐位置
  final Alignment alignment;

  JFormAvatarItemState({
    required ImageDataSource dataSource,
    this.color = Colors.white,
    this.elevation = 1.0,
    this.errorBuilder,
    this.placeholderBuilder,
    this.size = 35,
    this.circle = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.all(2),
    this.clickFullArea = true,
    this.alignment = Alignment.centerRight,
    OnAvatarUpload? onAvatarUpload,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this.controller = JAvatarController.withMenu(
          dataSource: dataSource,
          onAvatarUpload: onAvatarUpload,
          pickImage: pickImage,
          takePhoto: takePhoto,
        );

  @override
  Widget buildFormItem(
      BuildContext context, FormFieldState<ImageDataSource> field) {
    return buildDefaultItem(
      field: field,
      child: Container(
        alignment: alignment,
        child: JAvatar(
          controller: controller,
          color: color,
          elevation: elevation,
          errorBuilder: errorBuilder,
          placeholderBuilder: placeholderBuilder,
          size: size,
          circle: circle,
          borderRadius: borderRadius,
          padding: padding,
          onChange: (dataSource) => field.didChange(dataSource),
        ),
      ),
      defaultConfig: widget.defaultConfig?.copyWith(
        onTap: clickFullArea
            ? (value) {
                if (clickFullArea) {
                  controller.pickAvatar(context).then((value) {
                    if (null != value) field.didChange(value);
                  });
                }
                widget.defaultConfig?.onTap?.call(value);
              }
            : widget.defaultConfig?.onTap,
      ),
    );
  }
}
