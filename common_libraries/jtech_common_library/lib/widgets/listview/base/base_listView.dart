import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';

import 'controller.dart';

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

  BaseListView({
    required this.controller,
    required this.itemBuilder,
    this.dividerBuilder,
  });

  @override
  void initState() {
    super.initState();
    //注册数据变化监听
    controller.registerOnDataChange((_) {
      refreshUI(() {});
    });
  }
}