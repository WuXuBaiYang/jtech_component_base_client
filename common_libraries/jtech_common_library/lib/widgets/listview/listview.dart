import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';
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

  //是否展示分割线
  final bool showDivider;

  JListView({
    required JListViewController<V> controller,
    required ListItemBuilder<V> itemBuilder,
    ListDividerBuilder? dividerBuilder,
    this.canScroll = true,
    this.showDivider = false,
  }) : super(
          controller: controller,
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: scrollPhysics,
      itemCount: controller.dataLength,
      itemBuilder: (context, index) {
        var item = controller.getItem(index);
        return itemBuilder(context, item, index);
      },
      separatorBuilder: _buildDivider,
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();

  //构建分割线
  Widget _buildDivider(BuildContext context, int index) {
    if (!showDivider || null == dividerBuilder) return EmptyBox();
    return dividerBuilder!(context, index);
  }
}
