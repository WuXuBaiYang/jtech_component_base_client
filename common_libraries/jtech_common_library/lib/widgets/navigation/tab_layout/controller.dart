import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/navigation/base/controller.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';

/*
* 顶部tab导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 下午2:53
*/
class JTabLayoutController<T extends NavigationItem>
    extends BaseNavigationController<T> {
  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  JTabLayoutController({
    required List<T> items,
    int initialIndex = 0,
  })  : _badges = MapValueChangeNotifier.empty(),
        super(
          items: items,
          initialIndex: initialIndex,
        );

  @override
  void addChangeListener(OnNavigationChange onChange) {
    super.addChangeListener(onChange);
    _badges.addListener(() => onChange(currentIndex));
  }

  //根据下标获取角标对象
  Widget? getBadge(int index) => _badges.value[index];

  //添加角标
  void addBadge(int index, JBadgeView badge) => _badges.putValue(index, badge);

  //移除角标
  void removeBadge(int index) => _badges.removeValue(index);

  @override
  dispose() {
    super.dispose();
    //销毁数据
    _badges.dispose();
  }
}
