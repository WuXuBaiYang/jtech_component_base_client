import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//弹窗点击事件回调-异步
typedef DialogOptionTapAsync<T> = Future<T> Function();
//弹窗点击事件回调
typedef DialogOptionTap<T> = T Function();

/*
* 自定义弹窗配置对象
* @author wuxubaiyang
* @Time 2021/7/8 下午4:15
*/
class DialogConfig<T> extends BaseConfig{
  //内间距
  EdgeInsets padding;

  //外间距
  EdgeInsets margin;

  //设置弹窗背景色
  Color dialogColor;

  //容器最大最小宽高限制
  BoxConstraints constraints;

  //标题居中显示
  bool centerTitle;

  //标题左侧的图标
  Widget? titleIcon;

  //标题
  Widget? title;

  //标题部分内间距
  EdgeInsets titlePadding;

  //内容部分内间距
  EdgeInsets contentPadding;

  //内容部分视图
  Widget? content;

  //操作部分内间距
  EdgeInsets optionsPadding;

  //确认按钮对象
  Widget? confirmItem;

  //确认按钮点击事件
  DialogOptionTap<T>? confirmTap;

  //确认按钮异步点击事件
  DialogOptionTapAsync<T>? confirmTapAsync;

  //取消按钮对象
  Widget? cancelItem;

  //取消按钮点击事件
  DialogOptionTap<T>? cancelTap;

  //取消按钮异步点击事件
  DialogOptionTapAsync<T>? cancelTapAsync;

  //操作按钮文本对象
  Widget? optionItem;

  //操作按钮点击事件
  DialogOptionTap<T>? optionTap;

  //操作按钮异步点击事件
  DialogOptionTapAsync<T>? optionTapAsync;

  //点击按钮是否关闭dialog
  bool tapDismiss;

  //如果点击事件返回null，是否继续关闭dialog
  bool nullToDismiss;

  DialogConfig({
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.symmetric(vertical: 120, horizontal: 55),
    this.dialogColor = Colors.white,
    double minWidth = 0,
    double minHeight = 0,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    this.centerTitle = false,
    this.titleIcon,
    this.title,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.contentPadding =
    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.content,
    this.optionsPadding = EdgeInsets.zero,
    this.confirmItem,
    this.confirmTap,
    this.confirmTapAsync,
    this.cancelItem,
    this.cancelTap,
    this.cancelTapAsync,
    this.optionItem,
    this.optionTap,
    this.optionTapAsync,
    this.tapDismiss = true,
    this.nullToDismiss = true,
  }) : constraints = BoxConstraints(
    minWidth: minWidth,
    minHeight: minHeight,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );

  //判断标题部分组件是否展示
  bool get showTitle => null != titleIcon || null != title;

  //判断内容部分组件是否展示
  bool get showContent => null != content;

  //判断操作部分组件是否展示
  bool get showOptions =>
      null != confirmItem || null != cancelItem || null != optionItem;

  //执行操作按钮事件
  Future<T?> runOptionTap() async =>
      optionTap?.call() ?? await optionTapAsync?.call();

  //执行取消按钮事件
  Future<T?> runCancelTap() async =>
      cancelTap?.call() ?? await cancelTapAsync?.call();

  //执行确认按钮事件
  Future<T?> runConfirmTap() async =>
      confirmTap?.call() ?? await confirmTapAsync?.call();

  @override
  DialogConfig<T> copyWith({
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? dialogColor,
    double? minWidth,
    double? minHeight,
    double? maxWidth,
    double? maxHeight,
    bool? centerTitle,
    Widget? titleIcon,
    Widget? title,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    Widget? content,
    EdgeInsets? optionsPadding,
    Widget? confirmItem,
    DialogOptionTap<T>? confirmTap,
    DialogOptionTapAsync<T>? confirmTapAsync,
    Widget? cancelItem,
    DialogOptionTap<T>? cancelTap,
    DialogOptionTapAsync<T>? cancelTapAsync,
    Widget? optionItem,
    DialogOptionTap<T>? optionTap,
    DialogOptionTapAsync<T>? optionTapAsync,
    bool? tapDismiss,
    bool? nullToDismiss,
  }) {
    return DialogConfig<T>(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      dialogColor: dialogColor ?? this.dialogColor,
      minWidth: minWidth ?? this.constraints.minWidth,
      minHeight: minHeight ?? this.constraints.minHeight,
      maxWidth: maxWidth ?? this.constraints.maxWidth,
      maxHeight: maxHeight ?? this.constraints.maxHeight,
      centerTitle: centerTitle ?? this.centerTitle,
      titleIcon: titleIcon ?? this.titleIcon,
      title: title ?? this.title,
      titlePadding: titlePadding ?? this.titlePadding,
      contentPadding: contentPadding ?? this.contentPadding,
      content: content ?? this.content,
      optionsPadding: optionsPadding ?? this.optionsPadding,
      confirmItem: confirmItem ?? this.confirmItem,
      confirmTap: confirmTap ?? this.confirmTap,
      confirmTapAsync: confirmTapAsync ?? this.confirmTapAsync,
      cancelItem: cancelItem ?? this.cancelItem,
      cancelTap: cancelTap ?? this.cancelTap,
      cancelTapAsync: cancelTapAsync ?? this.cancelTapAsync,
      optionItem: optionItem ?? this.optionItem,
      optionTap: optionTap ?? this.optionTap,
      optionTapAsync: optionTapAsync ?? this.optionTapAsync,
      tapDismiss: tapDismiss ?? this.tapDismiss,
      nullToDismiss: nullToDismiss ?? this.nullToDismiss,
    );
  }
}