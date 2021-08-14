import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 列表基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:24
*/
class JListView<T extends JListViewController<V>, V>
    extends BaseStatefulWidgetMultiply {
  //子项构造器
  final ListItemBuilder<V> itemBuilder;

  //基本配置参数
  final ListViewConfig<V> config;

  //控制器
  final T controller;

  JListView({
    required State<JListView<T, V>> currentState,
    required this.controller,
    required this.itemBuilder,
    required this.config,
  }) : super(currentState: currentState);

  //构建默认列表组件
  static JListView def<V>({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    required JListViewController<V> controller,
    ListDividerBuilder? dividerBuilder,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //默认列表组件参数
    bool canScroll = true,
  }) {
    return JListView<JListViewController<V>, V>(
      controller: controller,
      itemBuilder: itemBuilder,
      currentState: JListViewDefaultState(
        canScroll: canScroll,
      ),
      config: (config ?? ListViewConfig()).copyWith(
        itemTap: itemTap,
        itemLongTap: itemLongTap,
        dividerBuilder: dividerBuilder,
      ),
    );
  }

  //构建刷新列表组件
  static JListView refresh<V>({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    ListDividerBuilder? dividerBuilder,
    JRefreshListViewController<V>? controller,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //刷新列表组件参数
    required OnRefreshLoad<V> onRefreshLoad,
    bool? enablePullDown,
    bool? enablePullUp,
    RefreshConfig<V>? refreshConfig,
  }) {
    return JListView<JRefreshListViewController<V>, V>(
      controller: controller ?? JRefreshListViewController(),
      itemBuilder: itemBuilder,
      currentState: JListViewRefreshState(
        refreshConfig: (refreshConfig ?? RefreshConfig<V>()).copyWith(
          onRefreshLoad: onRefreshLoad,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
        ),
      ),
      config: (config ?? ListViewConfig()).copyWith(
        itemTap: itemTap,
        itemLongTap: itemLongTap,
        dividerBuilder: dividerBuilder,
      ),
    );
  }

  //构建索引列表组件
  static JListView index<V extends BaseIndexModel>({
    //基本参数结构
    required ListItemBuilder<V> itemBuilder,
    required JIndexListViewController<V> controller,
    ListDividerBuilder? dividerBuilder,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    ListViewConfig<V>? config,
    //默认表格组件参数
    SusConfig? susConfig,
    IndexBarConfig? indexBarConfig,
  }) {
    return JListView<JIndexListViewController<V>, V>(
      controller: controller,
      itemBuilder: itemBuilder,
      currentState: JListViewIndexState(
        susConfig: susConfig,
        indexBarConfig: indexBarConfig,
      ),
      config: (config ?? ListViewConfig()).copyWith(
        itemTap: itemTap,
        itemLongTap: itemLongTap,
        dividerBuilder: dividerBuilder,
      ),
    );
  }
}

/*
* 列表组件状态基类
* @author jtechjh
* @Time 2021/8/13 5:09 下午
*/
abstract class BaseJListViewState<T extends JListViewController<V>, V>
    extends BaseState<JListView<T, V>> {
  //列表子项构造事件
  Widget buildListItem(BuildContext context, V item, int index) {
    return InkWell(
      child: widget.itemBuilder(context, item, index),
      onTap: null != widget.config.itemTap
          ? () => widget.config.itemTap!(item, index)
          : null,
      onLongPress: null != widget.config.itemLongTap
          ? () => widget.config.itemLongTap!(item, index)
          : null,
    );
  }

  //构建分割线
  Widget buildDivider(BuildContext context, int index) {
    if (null == widget.config.dividerBuilder) return EmptyBox();
    return widget.config.dividerBuilder!(context, index);
  }
}
