import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表格组件
* @author wuxubaiyang
* @Time 2021/7/19 下午4:06
*/
class JGridView<T extends JListViewController<V>, V>
    extends BaseStatefulWidgetMultiply {
  //副方向上的最大元素数量
  final int crossAxisCount;

  //子项构造器
  final GridItemBuilder<V>? itemBuilder;

  //基本配置参数
  final GridViewConfig<V> config;

  //控制器
  final T controller;

  JGridView({
    required this.controller,
    required this.crossAxisCount,
    required this.itemBuilder,
    required this.config,
    required State<JGridView<T, V>> currentState,
  }) : super(currentState: currentState);

  //创建基本表格组件
  static JGridView def<V>({
    //基本参数结构
    required int crossAxisCount,
    required GridItemBuilder<V> itemBuilder,
    required JGridViewController<V> controller,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    JStaggeredTile? staggeredTile,
    GridViewConfig<V>? config,
    //默认表格组件参数
    bool canScroll = true,
  }) {
    return JGridView<JGridViewController<V>, V>(
        controller: controller,
        crossAxisCount: crossAxisCount,
        itemBuilder: itemBuilder,
        currentState: JGridViewDefaultState(
          canScroll: canScroll,
        ),
        config: (config ?? GridViewConfig()).copyWith(
          itemTap: itemTap,
          itemLongTap: itemLongTap,
          staggeredTile: staggeredTile,
        ));
  }

  //创建刷新表格组件
  static JGridView refresh<V>({
    //基本参数结构
    required int crossAxisCount,
    required GridItemBuilder<V> itemBuilder,
    JRefreshGridViewController<V>? controller,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    JStaggeredTile? staggeredTile,
    GridViewConfig<V>? config,
    //刷新表格组件参数
    required OnRefreshLoad<V> onRefreshLoad,
    bool? enablePullDown,
    bool? enablePullUp,
    RefreshConfig<V>? refreshConfig,
  }) {
    return JGridView<JRefreshGridViewController<V>, V>(
      controller: controller ?? JRefreshGridViewController(),
      crossAxisCount: crossAxisCount,
      itemBuilder: itemBuilder,
      currentState: JGridViewRefreshState(
        refreshConfig: (refreshConfig ?? RefreshConfig<V>()).copyWith(
          onRefreshLoad: onRefreshLoad,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
        ),
      ),
      config: (config ?? GridViewConfig()).copyWith(
        itemTap: itemTap,
        itemLongTap: itemLongTap,
        staggeredTile: staggeredTile,
      ),
    );
  }

  //创建附件表格组件
  static JGridView accessory({
    //基本参数结构
    int crossAxisCount = 3,
    GridItemBuilder<JFileInfo>? itemBuilder,
    JAccessoryGridViewController<JFileInfo>? controller,
    OnGridItemTap<JFileInfo>? itemTap,
    OnGridItemLongTap<JFileInfo>? itemLongTap,
    JStaggeredTile? staggeredTile,
    GridViewConfig<JFileInfo>? config,
    //附件表格组件参数
    int maxCount = 9,
    Widget? addButton,
    Widget? deleteButton,
    Alignment deleteAlign = Alignment.topRight,
    bool canScroll = true,
    required List<PickerMenuItem> menuItems,
    OnAccessoryFilePreview? onFilePreview,
  }) {
    return JGridView<JAccessoryGridViewController<JFileInfo>, JFileInfo>(
      controller: controller ?? JAccessoryGridViewController(),
      crossAxisCount: crossAxisCount,
      itemBuilder: itemBuilder,
      currentState: JAccessoryRefreshState(
        maxCount: maxCount,
        addButton: addButton,
        deleteButton: deleteButton,
        deleteAlign: deleteAlign,
        canScroll: canScroll,
        menuItems: menuItems,
        onFilePreview: onFilePreview,
      ),
      config: (config ?? GridViewConfig()).copyWith(
        itemTap: itemTap,
        itemLongTap: itemLongTap,
        staggeredTile: staggeredTile ?? JStaggeredTile.count(1, 1),
      ),
    );
  }
}

/*
* 表格组件状态基类
* @author jtechjh
* @Time 2021/8/13 3:06 下午
*/
abstract class BaseJGridViewState<T extends JListViewController<V>, V>
    extends BaseState<JGridView<T, V>> {
  //表格子项构造事件
  Widget buildGridItem(BuildContext context, V item, int index) {
    return InkWell(
      child: widget.itemBuilder?.call(context, item, index),
      onTap: null != widget.config.itemTap
          ? () => widget.config.itemTap!(item, index)
          : null,
      onLongPress: null != widget.config.itemLongTap
          ? () => widget.config.itemLongTap!(item, index)
          : null,
    );
  }

  //表格分割构造事件
  StaggeredTile buildGridStaggered(V item, int index) {
    var staggered = widget.config.staggeredTileBuilder?.call(item, index);
    return (staggered ?? widget.config.staggeredTile).staggered;
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
  }
}
