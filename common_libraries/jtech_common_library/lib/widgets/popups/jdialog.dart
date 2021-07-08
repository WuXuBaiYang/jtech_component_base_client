import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

/*
* dialog弹窗管理
* @author wuxubaiyang
* @Time 2021/7/8 下午2:11
*/
class JDialog {
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

  //聚合弹窗对象
  Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required CustomDialogConfig<T> config,
  }) {
    return showDialog<T>(
      context,
      builder: (context) => _buildCustomDialog(config),
    );
  }

  //构建自定义弹窗
  Widget _buildCustomDialog(CustomDialogConfig config) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: config.constraints,
          child: Card(
            margin: config.margin,
            child: Padding(
              padding: config.padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCustomDialogTitle(config),
                  _buildCustomDialogContent(config),
                  _buildCustomDialogOptions(config),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //构建自定义弹窗标题部分
  _buildCustomDialogTitle(CustomDialogConfig config) {
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
  _buildCustomDialogContent(CustomDialogConfig config) {
    if (!config.showContent) return EmptyBox();
    return Padding(
      padding: config.contentPadding,
      child: Row(
        children: [
          config.content ?? EmptyBox(),
        ],
      ),
    );
  }

  //构建自定义弹窗操作部分
  _buildCustomDialogOptions(CustomDialogConfig config) {
    if (!config.showOptions) return EmptyBox();
    return Padding(
      padding: config.optionsPadding,
      child: Row(
        children: [
          TextButton(
            child: config.optionText ?? EmptyBox(),
            onPressed: () async {
              var result = await config.runOptionTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
          Expanded(child: EmptyBox()),
          TextButton(
            child: config.cancelText ?? EmptyBox(),
            onPressed: () async {
              var result = await config.runCancelTap();
              if (config.nullToDismiss || null != result) {
                await jBase.router.pop(result);
              }
            },
          ),
          TextButton(
            child: config.confirmText ?? EmptyBox(),
            onPressed: () async {
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

//弹窗点击事件回调-异步
typedef DialogOptionTapAsync<T> = Future<T> Function();
//弹窗点击事件回调
typedef DialogOptionTap<T> = T Function();

/*
* 自定义弹窗配置对象
* @author wuxubaiyang
* @Time 2021/7/8 下午4:15
*/
class CustomDialogConfig<T> {
  //内间距
  final EdgeInsets padding;

  //外间距
  final EdgeInsets margin;

  //容器最大最小宽高限制
  final BoxConstraints constraints;

  //标题居中显示
  final bool centerTitle;

  //标题左侧的图标
  final Widget? titleIcon;

  //标题
  final Widget? title;

  //标题部分内间距
  final EdgeInsets titlePadding;

  //内容部分内间距
  final EdgeInsets contentPadding;

  //内容部分视图
  final Widget? content;

  //操作部分内间距
  final EdgeInsets optionsPadding;

  //确认按钮文本对象
  final Widget? confirmText;

  //确认按钮点击事件
  final DialogOptionTap<T>? confirmTap;

  //确认按钮异步点击事件
  final DialogOptionTapAsync<T>? confirmTapAsync;

  //取消按钮文本对象
  final Widget? cancelText;

  //取消按钮点击事件
  final DialogOptionTap<T>? cancelTap;

  //取消按钮异步点击事件
  final DialogOptionTapAsync<T>? cancelTapAsync;

  //操作按钮文本对象
  final Widget? optionText;

  //操作按钮点击事件
  final DialogOptionTap<T>? optionTap;

  //操作按钮异步点击事件
  final DialogOptionTapAsync<T>? optionTapAsync;

  //点击按钮是否关闭dialog
  final bool tapDismiss;

  //如果点击事件返回null，是否继续关闭dialog
  final bool nullToDismiss;

  CustomDialogConfig({
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.symmetric(vertical: 120, horizontal: 55),
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
    this.confirmText,
    this.confirmTap,
    this.confirmTapAsync,
    this.cancelText,
    this.cancelTap,
    this.cancelTapAsync,
    this.optionText,
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
      null != confirmText || null != cancelText || null != optionText;

  //执行操作按钮事件
  Future<T?> runOptionTap() async =>
      optionTap?.call() ?? await optionTapAsync?.call();

  //执行取消按钮事件
  Future<T?> runCancelTap() async =>
      cancelTap?.call() ?? await cancelTapAsync?.call();

  //执行确认按钮事件
  Future<T?> runConfirmTap() async =>
      confirmTap?.call() ?? await confirmTapAsync?.call();
}
