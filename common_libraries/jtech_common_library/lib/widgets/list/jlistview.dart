import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/list/BaseListView.dart';

/*
* 通用列表组件
* @author wuxubaiyang
* @Time 2021/7/2 下午5:20
*/
class JListView<V> extends BaseListView<JListViewController<V>, V> {
  JListView({
    required JListViewController<V>? controller,
    required ListItemBuilder<V>? itemBuilder,
    ListDividerBuilder? dividerBuilder,
  }) : super(
          controller: controller,
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
