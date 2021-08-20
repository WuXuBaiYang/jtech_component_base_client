import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 基本表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JGridViewDefaultState<V>
    extends BaseJGridViewState<JGridViewController<V>, V> {
  //判断是否可滚动
  final bool canScroll;

  JGridViewDefaultState({
    this.canScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.config.margin,
      child: ValueListenableBuilder<List<V>>(
        valueListenable: widget.controller.dataListenable,
        builder: (context, dataList, child) {
          return StaggeredGridView.countBuilder(
            itemBuilder: (context, index) =>
                buildGridItem(context, dataList[index], index),
            staggeredTileBuilder: (int index) =>
                buildGridStaggered(dataList[index], index),
            mainAxisSpacing: widget.config.mainAxisSpacing,
            crossAxisSpacing: widget.config.crossAxisSpacing,
            crossAxisCount: widget.crossAxisCount,
            itemCount: dataList.length,
            physics: scrollPhysics,
            shrinkWrap: true,
          );
        },
      ),
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}
