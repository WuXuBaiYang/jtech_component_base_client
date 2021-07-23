import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/listview/base/base_listView.dart';

import 'base/controller.dart';

/*
* 通用列表组件
* @author wuxubaiyang
* @Time 2021/7/2 下午5:20
*/
class JListView<V> extends BaseListView<JListViewController<V>, V> {
  //判断是否可滚动
  final bool canScroll;

  JListView({
    required JListViewController<V> controller,
    required ListItemBuilder<V> itemBuilder,
    ListDividerBuilder? dividerBuilder,
    this.canScroll = true,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
  }) : super(
          controller: controller,
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: controller.dataListenable,
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
