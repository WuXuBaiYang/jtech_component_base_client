import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'config.dart';

//菜单点击事件
typedef OnMenuItemTap<T> = void Function(T item, int index);
//菜单长点击事件
typedef OnMenuItemLongPress<T> = void Function(T item, int index);

/*
* 弹出窗口
* @author wuxubaiyang
* @Time 2021/7/9 上午9:30
*/
class JSheet extends BaseManage {
  static final JSheet _instance = JSheet._internal();

  factory JSheet() => _instance;

  JSheet._internal();

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
    Widget? cancelItem = const CloseButton(),
    Widget? confirmItem,
    SheetOptionTap<T>? cancelTap,
    SheetOptionTap<T>? confirmTap,
    SheetConfig<T>? config,
    bool inSafeArea = true,
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
      inSafeArea: inSafeArea,
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

  //展示底部弹出列表
  //展示底部弹出菜单
  Future<V?> showMenuBottomSheet<V, T extends MenuItem>(
    BuildContext context, {
    required List<T> items,
    SheetConfig<V>? config,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets contentPadding = EdgeInsets.zero,
    bool showDivider = true,
    OnMenuItemTap<T>? onItemTap,
    OnMenuItemLongPress<T>? onItemLongPress,
    bool canScroll = true,
  }) {
    return showCustomBottomSheet<V>(
      context,
      config: (config ?? SheetConfig()).copyWith(
        padding: padding,
        contentPadding: contentPadding,
        content: ListView.separated(
          separatorBuilder: (_, __) => showDivider ? Divider() : EmptyBox(),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          physics: canScroll ? null : NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var item = items[index];
            return ListTile(
              leading: item.leading,
              title: item.title,
              subtitle: item.subTitle,
              onTap: () {
                onItemTap?.call(item, index);
                item.onTap?.call();
              },
              onLongPress: () {
                onItemLongPress?.call(item, index);
                item.onLongPress?.call();
              },
              trailing: item.trailing,
            );
          },
        ),
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
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
            onTap: () async {
              var result = await config.runCancelTap();
              if (config.nullToDismiss || null != result) {
                jBase.router.pop(result);
              }
            },
          ),
          Align(
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
        ],
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
            child: config.cancelItem,
            onTap: () async {
              var result = await config.runCancelTap();
              if (config.nullToDismiss || null != result) {
                jBase.router.pop(result);
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
            child: config.confirmItem,
            onTap: () async {
              var result = await config.runConfirmTap();
              if (config.nullToDismiss || null != result) {
                jBase.router.pop(result);
              }
            },
          ),
        ],
      ),
    );
  }

  //构建自定义底部sheet操作部分容器
  _buildCustomBottomSheetOptionItem({
    required Widget? child,
    required VoidCallback onTap,
  }) {
    if (null == child) return EmptyBox();
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

//单例调用
final jSheet = JSheet();
