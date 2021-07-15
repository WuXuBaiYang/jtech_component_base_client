import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';

import 'config.dart';

/*
* 弹出窗口
* @author wuxubaiyang
* @Time 2021/7/9 上午9:30
*/
@protected
class Sheet {
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
