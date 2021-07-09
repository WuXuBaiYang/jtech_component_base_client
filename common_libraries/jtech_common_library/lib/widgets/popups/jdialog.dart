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
    CustomDialogConfig<T>? config,
  }) {
    return showCustomDialog(
      context,
      config: (config ?? CustomDialogConfig()).copyWith(
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
    required CustomDialogConfig<T> config,
  }) {
    return showDialog<T>(
      context,
      builder: (context) => _buildCustomDialog(config),
    );
  }

  //构建自定义弹窗
  Widget _buildCustomDialog(CustomDialogConfig config) {
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
      child: config.content ?? EmptyBox(),
    );
  }

  //构建自定义弹窗操作部分
  _buildCustomDialogOptions(CustomDialogConfig config) {
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

  CustomDialogConfig({
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

  //从已有参数中拷贝覆盖
  CustomDialogConfig<T> copyWith({
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
    return CustomDialogConfig<T>(
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
