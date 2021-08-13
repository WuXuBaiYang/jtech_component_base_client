import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/listview/listview_default.dart';
import 'controller.dart';

/*
* 列表基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:24
*/
class JListView<V> extends BaseStatefulWidget {
  //当前列表组件状态
  final BaseJListViewState currentState;

  //构建默认列表组件
  JListView({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    required JListViewController<V> controller,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //默认列表组件参数
    bool canScroll = true,
  }) : this.currentState = JListViewDefaultState<V>(
          itemBuilder: itemBuilder,
          controller: controller,
          canScroll: canScroll,
          config: (config ?? ListViewConfig<V>()).copyWith(
            itemTap: itemTap,
            itemLongTap: itemLongTap,
          ),
        );

  //构建刷新列表组件
  JListView.refresh({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    required JRefreshListViewController<V> controller,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //刷新列表组件参数
    required OnRefreshLoad<V> onRefreshLoad,
    bool? enablePullDown,
    bool? enablePullUp,
    RefreshConfig<V>? refreshConfig,
  }) : this.currentState = JListViewRefreshState<V>(
          itemBuilder: itemBuilder,
          controller: controller,
          refreshConfig: (refreshConfig ?? RefreshConfig<V>()).copyWith(
            onRefreshLoad: onRefreshLoad,
            enablePullDown: enablePullDown,
            enablePullUp: enablePullUp,
          ),
          config: (config ?? ListViewConfig<V>()).copyWith(
            itemTap: itemTap,
            itemLongTap: itemLongTap,
          ),
        );

  //构建索引列表组件
  JListView.index({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    required JIndexListViewController<V> controller,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //默认表格组件参数
    SusConfig? susConfig,
    IndexBarConfig? indexBarConfig,
  }) : this.currentState = JListViewIndexState<V>(
          itemBuilder: itemBuilder,
          controller: controller,
          susConfig: susConfig,
          indexBarConfig: indexBarConfig,
          config: (config ?? ListViewConfig<V>()).copyWith(
            itemTap: itemTap,
            itemLongTap: itemLongTap,
          ),
        );

  @override
  BaseJListViewState getState() => currentState;
}

/*
* 列表组件状态基类
* @author jtechjh
* @Time 2021/8/13 5:09 下午
*/
abstract class BaseJListViewState<T extends JListViewController<V>, V>
    extends BaseState<JListView> {
  //控制器
  final T controller;

  //子项构造器
  final ListItemBuilder<V> itemBuilder;

  //基本配置参数
  final ListViewConfig<V> config;

  BaseJListViewState({
    required this.controller,
    required this.itemBuilder,
    required this.config,
  });

  //列表子项构造事件
  Widget buildListItem(BuildContext context, V item, int index) {
    return InkWell(
      child: itemBuilder(context, item, index),
      onTap: null != config.itemTap ? () => config.itemTap!(item, index) : null,
      onLongPress: null != config.itemLongTap
          ? () => config.itemLongTap!(item, index)
          : null,
    );
  }

  //构建分割线
  Widget buildDivider(BuildContext context, int index) {
    if (null == config.dividerBuilder) return EmptyBox();
    return config.dividerBuilder!(context, index);
  }
}
