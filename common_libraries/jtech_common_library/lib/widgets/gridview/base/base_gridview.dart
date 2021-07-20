import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/gridview/base/controller.dart';

import 'staggered.dart';

//表格子项点击事件
typedef OnGridItemTap<V> = void Function(V item, int index);

//表格子项长点击事件
typedef OnGridItemLongTap<V> = void Function(V item, int index);

//列表子项构造器
typedef GridItemBuilder<V> = Widget Function(
    BuildContext context, V item, int index);

//表格分割回调
typedef StaggeredTileBuilder<V> = JStaggeredTile? Function(V item, int index);

/*
* 表格列表组件基类
* @author wuxubaiyang
* @Time 2021/7/19 下午4:06
*/
abstract class BaseGridView<T extends JGridViewController<V>, V>
    extends BaseStatefulWidget {
  //表格控制器
  final T controller;

  //表格子项构造器
  final GridItemBuilder<V> itemBuilder;

  //点击事件
  final OnGridItemTap<V>? itemTap;

  //长点击事件
  final OnGridItemLongTap<V>? itemLongTap;

  //分割方式回调
  final StaggeredTileBuilder<V>? staggeredTileBuilder;

  //默认的分割方式（当没有分割构造器或者分割构造器返回空时使用）
  final JStaggeredTile staggeredTile;

  BaseGridView({
    required this.controller,
    required this.itemBuilder,
    this.itemTap,
    this.itemLongTap,
    this.staggeredTileBuilder,
    JStaggeredTile? staggeredTile,
  }) : this.staggeredTile = staggeredTile ?? JStaggeredTile.fit(1);

  //表格子项构造事件
  Widget buildGridItem(BuildContext context, V item, int index) {
    return InkWell(
      child: itemBuilder(context, item, index),
      onTap: null != itemTap ? () => itemTap!(item, index) : null,
      onLongPress: null != itemLongTap ? () => itemLongTap!(item, index) : null,
    );
  }

  //表格分割构造事件
  StaggeredTile buildGridStaggered(V item, int index) {
    var staggered = staggeredTileBuilder?.call(item, index);
    return (staggered ?? staggeredTile).staggered;
  }
}
