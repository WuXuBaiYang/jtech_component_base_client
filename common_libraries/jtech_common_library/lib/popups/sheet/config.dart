import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//底部sheet操作点击事件回调-异步
typedef SheetOptionTapAsync<T> = Future<T?> Function();
//底部sheet操作点击事件回调
typedef SheetOptionTap<T> = T? Function();

/*
* 自定义底部弹窗配置对象
* @author wuxubaiyang
* @Time 2021/7/9 上午11:11
*/
class SheetConfig<T> extends BaseConfig {
  //外间距
  EdgeInsetsGeometry margin;

  //内间距
  EdgeInsetsGeometry padding;

  //sheet背景色
  Color sheetColor;

  //整体背景色
  Color barrierColor;

  //sheet高度
  double? sheetHeight;

  //标题对象
  Widget? title;

  //标题部分内间距
  EdgeInsetsGeometry titlePadding;

  //标题是否居中
  bool centerTitle;

  //标题左侧取消对象
  Widget? cancelItem;

  //标题左侧取消点击事件
  SheetOptionTap<T>? cancelTap;

  //标题左侧取消点击事件-异步
  SheetOptionTapAsync<T>? cancelTapAsync;

  //标题右侧确认对象
  Widget? confirmItem;

  //标题右侧确认点击事件
  SheetOptionTap<T>? confirmTap;

  //标题右侧确认点击事件-异步
  SheetOptionTapAsync<T>? confirmTapAsync;

  //内容对象
  Widget? content;

  //内容部分内间距
  EdgeInsetsGeometry contentPadding;

  //如果点击事件返回null，是否继续关闭dialog
  bool nullToDismiss;

  //是否在安全范围内展示
  bool inSafeArea;

  SheetConfig({
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(15),
    this.sheetColor = Colors.white,
    this.barrierColor = kCupertinoModalBarrierColor,
    this.sheetHeight,
    this.title,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 8),
    this.centerTitle = true,
    this.cancelItem,
    this.confirmItem,
    this.content,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.cancelTap,
    this.cancelTapAsync,
    this.confirmTap,
    this.confirmTapAsync,
    this.nullToDismiss = true,
    this.inSafeArea = false,
  });

  //判断标题部分组件是否展示
  bool get showTitle =>
      null != cancelItem || null != title || null != confirmItem;

  //判断内容部分组件是否展示
  bool get showContent => null != content;

  //执行取消按钮事件
  Future<T?> runCancelTap() async =>
      cancelTap?.call() ?? await cancelTapAsync?.call();

  //执行确认按钮事件
  Future<T?> runConfirmTap() async =>
      confirmTap?.call() ?? await confirmTapAsync?.call();

  @override
  SheetConfig<T> copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? sheetColor,
    Color? barrierColor,
    double? sheetHeight,
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
    bool? centerTitle,
    Widget? cancelItem,
    Widget? confirmItem,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    SheetOptionTap<T>? cancelTap,
    SheetOptionTapAsync<T>? cancelTapAsync,
    SheetOptionTap<T>? confirmTap,
    SheetOptionTapAsync<T>? confirmTapAsync,
    bool? nullToDismiss,
    bool? inSafeArea,
  }) {
    return SheetConfig<T>(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      sheetColor: sheetColor ?? this.sheetColor,
      barrierColor: barrierColor ?? this.barrierColor,
      sheetHeight: sheetHeight ?? this.sheetHeight,
      title: title ?? this.title,
      titlePadding: titlePadding ?? this.titlePadding,
      centerTitle: centerTitle ?? this.centerTitle,
      cancelItem: cancelItem ?? this.cancelItem,
      confirmItem: confirmItem ?? this.confirmItem,
      content: content ?? this.content,
      contentPadding: contentPadding ?? this.contentPadding,
      cancelTap: cancelTap ?? this.cancelTap,
      cancelTapAsync: cancelTapAsync ?? this.cancelTapAsync,
      confirmTap: confirmTap ?? this.confirmTap,
      confirmTapAsync: confirmTapAsync ?? this.confirmTapAsync,
      nullToDismiss: nullToDismiss ?? this.nullToDismiss,
      inSafeArea: inSafeArea ?? this.inSafeArea,
    );
  }
}
