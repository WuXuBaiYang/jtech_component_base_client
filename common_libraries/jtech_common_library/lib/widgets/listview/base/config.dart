import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//列表子项点击事件
typedef OnListItemTap<V> = void Function(V item, int index);

//列表子项长点击事件
typedef OnListItemLongTap<V> = void Function(V item, int index);

//列表子项构造器
typedef ListItemBuilder<V> = Widget Function(
    BuildContext context, V item, int index);

//列表分割线构造器
typedef ListDividerBuilder = Widget Function(BuildContext context, int index);

/*
* 列表组件基本配置
* @author jtechjh
* @Time 2021/8/13 3:11 下午
*/
class ListViewConfig<V> extends BaseConfig {
  //点击事件
  final OnListItemTap<V>? itemTap;

  //长点击事件
  final OnListItemLongTap<V>? itemLongTap;

  //列表分割线构造器
  final ListDividerBuilder? dividerBuilder;

  ListViewConfig({
    this.itemTap,
    this.itemLongTap,
    this.dividerBuilder,
  });

  @override
  ListViewConfig<V> copyWith({
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    ListDividerBuilder? dividerBuilder,
  }) {
    return ListViewConfig<V>(
      itemTap: itemTap ?? this.itemTap,
      itemLongTap: itemLongTap ?? this.itemLongTap,
      dividerBuilder: dividerBuilder ?? this.dividerBuilder,
    );
  }
}
