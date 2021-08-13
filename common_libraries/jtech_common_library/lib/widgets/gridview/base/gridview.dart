import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/gridview/base/config.dart';
import 'package:jtech_common_library/widgets/gridview/gridview_default.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';

/*
* 表格组件
* @author wuxubaiyang
* @Time 2021/7/19 下午4:06
*/
class JGridView<V> extends BaseStatefulWidget {
  //当前表格组件状态
  final BaseJGridViewState currentState;

  //创建基本表格组件
  JGridView({
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
  }) : this.currentState = JGridViewDefaultState<V>(
          itemBuilder: itemBuilder,
          controller: controller,
          crossAxisCount: crossAxisCount,
          canScroll: canScroll,
          config: (config ?? GridViewConfig<V>()).copyWith(
            itemTap: itemTap,
            itemLongTap: itemLongTap,
            staggeredTile: staggeredTile,
          ),
        );

  //创建刷新表格组件
  JGridView.refresh({
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
  }) : this.currentState = JGridViewRefreshState<V>(
          itemBuilder: itemBuilder,
          controller: controller,
          crossAxisCount: crossAxisCount,
          refreshConfig: (refreshConfig ?? RefreshConfig<V>()).copyWith(
            onRefreshLoad: onRefreshLoad,
            enablePullDown: enablePullDown,
            enablePullUp: enablePullUp,
          ),
          config: (config ?? GridViewConfig<V>()).copyWith(
            itemTap: itemTap,
            itemLongTap: itemLongTap,
            staggeredTile: staggeredTile,
          ),
        );

  @override
  BaseJGridViewState getState() => currentState;
}

/*
* 表格组件状态基类
* @author jtechjh
* @Time 2021/8/13 3:06 下午
*/
abstract class BaseJGridViewState<T extends JListViewController<V>, V>
    extends BaseState<JGridView> {
  //副方向上的最大元素数量
  final int crossAxisCount;

  //控制器
  final T controller;

  //子项构造器
  final GridItemBuilder<V> itemBuilder;

  //基本配置参数
  final GridViewConfig<V> config;

  BaseJGridViewState({
    required this.crossAxisCount,
    required this.controller,
    required this.itemBuilder,
    required this.config,
  });

  //表格子项构造事件
  Widget buildGridItem(BuildContext context, V item, int index) {
    return InkWell(
      child: itemBuilder(context, item, index),
      onTap: null != config.itemTap ? () => config.itemTap!(item, index) : null,
      onLongPress: null != config.itemLongTap
          ? () => config.itemLongTap!(item, index)
          : null,
    );
  }

  //表格分割构造事件
  StaggeredTile buildGridStaggered(V item, int index) {
    var staggered = config.staggeredTileBuilder?.call(item, index);
    return (staggered ?? config.staggeredTile).staggered;
  }
}
