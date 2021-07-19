import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';

import 'controller.dart';

//列表子项点击事件
typedef ListItemTap<V> = void Function(V item, int index);

//列表子项长点击事件
typedef ListItemLongTap<V> = void Function(V item, int index);

//列表子项构造器
typedef ListItemBuilder<V> = Widget Function(
    BuildContext context, V item, int index);

//列表分割线构造器
typedef ListDividerBuilder = Widget Function(BuildContext context, int index);

/*
* 列表基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:24
*/
abstract class BaseListView<T extends JListViewController<V>, V>
    extends BaseStatefulWidget {
  //列表控制器
  final T controller;

  //列表子项构造器
  final ListItemBuilder<V> itemBuilder;

  //列表分割线构造器
  final ListDividerBuilder? dividerBuilder;

  //点击事件
  final ListItemTap<V>? itemTap;

  //长点击事件
  final ListItemLongTap<V>? itemLongTap;

  BaseListView({
    required this.controller,
    required this.itemBuilder,
    this.dividerBuilder,
    this.itemTap,
    this.itemLongTap,
  });

  //列表子项构造事件
  Widget buildListItem(BuildContext context, V item, int index) {
    return InkWell(
      child: itemBuilder(context, item, index),
      onTap: () {
        if (null == itemTap) return null;
        return itemTap!(item, index);
      },
      onLongPress: () {
        if (null == itemLongTap) return null;
        return itemLongTap!(item, index);
      },
    );
  }
}
