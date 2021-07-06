import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/listview/BaseListView.dart';

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
      separatorBuilder: (context, index) {
        return dividerBuilder!(context, index);
      },
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}