import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

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
* 表格组件基本配置
* @author jtechjh
* @Time 2021/8/13 3:11 下午
*/
class GridViewConfig<V> extends BaseConfig {
  //整体边距
  final EdgeInsets margin;

  //主方向元素间距
  final double mainAxisSpacing;

  //副方向元素间距
  final double crossAxisSpacing;

  //点击事件
  final OnGridItemTap<V>? itemTap;

  //长点击事件
  final OnGridItemLongTap<V>? itemLongTap;

  //分割方式回调
  final StaggeredTileBuilder<V>? staggeredTileBuilder;

  //默认的分割方式（当没有分割构造器或者分割构造器返回空时使用）
  final JStaggeredTile staggeredTile;

  GridViewConfig({
    this.itemTap,
    this.itemLongTap,
    this.staggeredTileBuilder,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
    this.margin = EdgeInsets.zero,
    JStaggeredTile? staggeredTile,
  }) : this.staggeredTile = staggeredTile ?? JStaggeredTile.fit(1);

  @override
  GridViewConfig<V> copyWith({
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    StaggeredTileBuilder<V>? staggeredTileBuilder,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    JStaggeredTile? staggeredTile,
    EdgeInsets? margin,
  }) {
    return GridViewConfig<V>(
      itemTap: itemTap ?? this.itemTap,
      itemLongTap: itemLongTap ?? this.itemLongTap,
      staggeredTileBuilder: staggeredTileBuilder ?? this.staggeredTileBuilder,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      staggeredTile: staggeredTile ?? this.staggeredTile,
      margin: margin ?? this.margin,
    );
  }
}
