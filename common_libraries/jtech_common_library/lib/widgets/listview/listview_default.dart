import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 通用列表组件
* @author wuxubaiyang
* @Time 2021/7/2 下午5:20
*/
class JListViewDefaultState<V>
    extends BaseJListViewState<JListViewController<V>, V> {
  //判断是否可滚动
  final bool canScroll;

  JListViewDefaultState({
    this.canScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: widget.controller.dataListenable,
      builder: (context, dataList, child) {
        return ListView.separated(
          shrinkWrap: true,
          physics: scrollPhysics,
          itemCount: dataList.length,
          itemBuilder: (context, index) =>
              buildListItem(context, dataList[index], index),
          separatorBuilder: buildDivider,
        );
      },
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}
