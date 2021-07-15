import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/navigation/base/controller.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';

//导航变化监听
typedef OnNavigationChange = void Function(int index);

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController<T extends NavigationItem>
    extends BaseNavigationController<T> {
  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  JBottomNavigationController({
    required List<T> items,
    int initialIndex = 0,
  })  : assert(initialIndex >= 0 && initialIndex < items.length, "初始下标超出数据范围"),
        _badges = MapValueChangeNotifier.empty(),
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
  void addBadge(int index, JBadgeView badge) {
    if (isOverIndex(index)) return;
    _badges.putValue(index, badge);
  }

  //移除角标
  void removeBadge(int index) => _badges.removeValue(index);

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _badges.dispose();
  }
}
