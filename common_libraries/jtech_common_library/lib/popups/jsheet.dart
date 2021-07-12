import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

/*
* 弹出窗口
* @author wuxubaiyang
* @Time 2021/7/9 上午9:30
*/
class JSheet {
  //展示基本sheet
  Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    Color barrierColor = kCupertinoModalBarrierColor,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: builder,
      barrierColor: barrierColor,
    );
  }

  //设置全屏固定高度的sheet
  Future<T?> showFullBottomSheet<T>(
    BuildContext context, {
    required Widget content,
    Widget? title,
    Widget cancelItem = const CloseButton(),
    Widget? confirmItem,
    SheetOptionTap<T>? cancelTap,
    SheetOptionTap<T>? confirmTap,
    SheetConfig<T>? config,
  }) {
    return showFixedBottomSheet<T>(
      context,
      content: content,
      sheetHeight: MediaQuery.of(context).size.height,
      title: title,
      cancelItem: cancelItem,
      cancelTap: cancelTap,
      confirmItem: confirmItem,
      confirmTap: confirmTap,
      inSafeArea: true,
      config: config,
    );
  }

  //展示固定高度的底部sheet
  Future<T?> showFixedBottomSheet<T>(
    BuildContext context, {
    required Widget content,
    required double sheetHeight,
    Widget? title,
    Widget? cancelItem,
    Widget? confirmItem,
    SheetOptionTap<T>? cancelTap,
    SheetOptionTap<T>? confirmTap,
    bool inSafeArea = false,
    SheetConfig<T>? config,
  }) {
    return showCustomBottomSheet<T>(
      context,
      config: (config ?? SheetConfig()).copyWith(
        sheetHeight: sheetHeight,
        title: title,
        content: content,
        cancelItem: cancelItem,
        cancelTap: cancelTap,
        confirmItem: confirmItem,
        confirmTap: confirmTap,
        inSafeArea: inSafeArea,
      ),
    );
  }

  //展示聚合基础底部sheet
  Future<T?> showCustomBottomSheet<T>(
    BuildContext context, {
    required SheetConfig<T> config,
  }) {
    return showBottomSheet(
      context,
      barrierColor: config.barrierColor,
      builder: (context) => _buildCustomBottomSheet(config),
    );
  }

  //构建自定义底部sheet
  Widget _buildCustomBottomSheet(SheetConfig config) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCustomBottomSheetTitle(config),
        _buildCustomBottomSheetContent(config),
      ],
    );
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          color: config.sheetColor,
          margin: config.margin,
          child: Container(
            width: double.infinity,
            height: config.sheetHeight,
            padding: config.padding,
            child: config.inSafeArea ? SafeArea(child: content) : content,
          ),
        ),
      ),
    );
  }

  //构建自定义底部sheet标题部分
  _buildCustomBottomSheetTitle(SheetConfig config) {
    if (!config.showTitle) return EmptyBox();
    return Padding(
      padding: config.titlePadding,
      child: Row(
        children: [
          _buildCustomBottomSheetOptionItem(
            child: config.cancelItem ?? EmptyBox(),
            onTap: () async {
              var result = await config.runCancelTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              alignment:
                  config.centerTitle ? Alignment.center : Alignment.centerLeft,
              child: config.title,
            ),
          ),
          SizedBox(width: 8),
          _buildCustomBottomSheetOptionItem(
            child: config.confirmItem ?? EmptyBox(),
            onTap: () async {
              var result = await config.runConfirmTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
        ],
      ),
    );
  }

  //构建自定义底部sheet操作部分容器
  _buildCustomBottomSheetOptionItem({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return child is Text
        ? TextButton(onPressed: onTap, child: child)
        : IconButton(onPressed: onTap, icon: child);
  }

  //构建自定义底部sheet内容部分
  _buildCustomBottomSheetContent(SheetConfig config) {
    if (!config.showContent) return EmptyBox();
    return Padding(
      padding: config.contentPadding,
      child: config.content ?? EmptyBox(),
    );
  }
}

//底部sheet操作点击事件回调-异步
typedef SheetOptionTapAsync<T> = Future<T> Function();
//底部sheet操作点击事件回调
typedef SheetOptionTap<T> = T Function();

/*
* 自定义底部弹窗配置对象
* @author wuxubaiyang
* @Time 2021/7/9 上午11:11
*/
class SheetConfig<T> {
  //外间距
  EdgeInsets margin;

  //内间距
  EdgeInsets padding;

  //sheet背景色
  Color sheetColor;

  //整体背景色
  Color barrierColor;

  //sheet高度
  double sheetHeight;

  //标题对象
  Widget? title;

  //标题部分内间距
  EdgeInsets titlePadding;

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
  EdgeInsets contentPadding;

  //如果点击事件返回null，是否继续关闭dialog
  bool nullToDismiss;

  //是否在安全范围内展示
  bool inSafeArea;

  SheetConfig({
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(15),
    this.sheetColor = Colors.white,
    this.barrierColor = kCupertinoModalBarrierColor,
    this.sheetHeight = 120,
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

  //从参数中拷贝替换已有字段
  SheetConfig<T> copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? sheetColor,
    Color? barrierColor,
    double? sheetHeight,
    Widget? title,
    EdgeInsets? titlePadding,
    bool? centerTitle,
    Widget? cancelItem,
    Widget? confirmItem,
    Widget? content,
    EdgeInsets? contentPadding,
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
