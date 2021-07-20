import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/widgets/gridview/base/base_gridview.dart';
import 'package:jtech_common_library/widgets/gridview/base/controller.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';

/*
* 基本表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JGridView<V> extends BaseGridView<JGridViewController<V>, V> {
  //判断是否可滚动
  final bool canScroll;

  //副方向上的最大元素数量
  final int crossAxisCount;

  //主方向元素间距
  final double mainAxisSpacing;

  //副方向元素间距
  final double crossAxisSpacing;

  JGridView({
    required JGridViewController<V> controller,
    required GridItemBuilder<V> itemBuilder,
    required this.crossAxisCount,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
    this.canScroll = true,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    StaggeredTileBuilder? staggeredTileBuilder,
    JStaggeredTile? staggeredTile,
  }) : super(
          controller: controller,
          itemBuilder: itemBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
          staggeredTile: staggeredTile,
          staggeredTileBuilder: staggeredTileBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: controller.dataListenable,
      builder: (context, dataList, child) {
        return StaggeredGridView.countBuilder(
          itemBuilder: (context, index) =>
              buildGridItem(context, dataList[index], index),
          staggeredTileBuilder: (int index) =>
              buildGridStaggered(dataList[index], index),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          crossAxisCount: crossAxisCount,
          itemCount: dataList.length,
          physics: scrollPhysics,
          shrinkWrap: true,
        );
      },
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}
