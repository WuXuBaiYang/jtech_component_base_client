import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';

import 'config.dart';

/*
* dialog弹窗管理
* @author wuxubaiyang
* @Time 2021/7/8 下午2:11
*/
@protected
class Dialog {
  //弹窗基础方法
  Future<T?> showDialog<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder: builder,
    );
  }

  //提示弹窗
  Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required Widget content,
    Widget? titleIcon,
    Widget? title,
    Widget? cancelItem,
    DialogOptionTap<T>? cancelTap,
    Widget? confirmItem,
    DialogOptionTap<T>? confirmTap,
    DialogConfig<T>? config,
  }) {
    return showCustomDialog(
      context,
      config: (config ?? DialogConfig()).copyWith(
        titleIcon: titleIcon,
        title: title,
        content: content,
        cancelItem: cancelItem,
        cancelTap: cancelTap,
        confirmItem: confirmItem,
        confirmTap: confirmTap,
      ),
    );
  }

  //聚合弹窗对象
  Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required DialogConfig<T> config,
  }) {
    return showDialog<T>(
      context,
      builder: (context) => _buildCustomDialog(config),
    );
  }

  //构建自定义弹窗
  Widget _buildCustomDialog(DialogConfig config) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Card(
          margin: config.margin,
          color: config.dialogColor,
          child: Container(
            constraints: config.constraints,
            padding: config.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomDialogTitle(config),
                _buildCustomDialogContent(config),
                _buildCustomDialogOptions(config),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //构建自定义弹窗标题部分
  _buildCustomDialogTitle(DialogConfig config) {
    if (!config.showTitle) return EmptyBox();
    return Padding(
      padding: config.titlePadding,
      child: Row(
        mainAxisAlignment: config.centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          config.titleIcon ?? EmptyBox(),
          SizedBox(width: 8),
          config.title ?? EmptyBox(),
        ],
      ),
    );
  }

  //构建自定义弹窗内容部分
  _buildCustomDialogContent(DialogConfig config) {
    if (!config.showContent) return EmptyBox();
    return Padding(
      padding: config.contentPadding,
      child: config.content ?? EmptyBox(),
    );
  }

  //构建自定义弹窗操作部分
  _buildCustomDialogOptions(DialogConfig config) {
    if (!config.showOptions) return EmptyBox();
    return Padding(
      padding: config.optionsPadding,
      child: Row(
        children: [
          _buildCustomDialogOptionItem(
            child: config.optionItem ?? EmptyBox(),
            onTap: () async {
              var result = await config.runOptionTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
          Expanded(child: EmptyBox()),
          _buildCustomDialogOptionItem(
            child: config.cancelItem ?? EmptyBox(),
            onTap: () async {
              var result = await config.runCancelTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
          _buildCustomDialogOptionItem(
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

  //构建自定义弹窗操作部分容器
  _buildCustomDialogOptionItem({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return child is Text
        ? TextButton(onPressed: onTap, child: child)
        : IconButton(onPressed: onTap, icon: child);
  }

  //记录加载弹窗对象
  Future<void>? loadingDialog;

  //显示加载弹窗
  Future<void> showLoading(
    BuildContext context, {
    WidgetBuilder? builder,
    Size loadingSize = const Size(85, 85),
  }) async {
    await hideLoadingDialog();
    loadingDialog = showDialog(
      context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.fromSize(
              size: loadingSize,
              child: (builder ?? _defLoading)(context),
            ),
          ],
        );
      },
    )..whenComplete(() => loadingDialog = null);
    return loadingDialog;
  }

  //构建默认加载框样式
  Widget _defLoading(BuildContext context) {
    return Card(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  //隐藏加载弹窗
  Future<void> hideLoadingDialog() async {
    if (null == loadingDialog) return;
    await jBase.router.pop();
  }
}
