import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/base/controller.dart';
import 'package:jtech_common_library/widgets/base/value_change_notifier.dart';

import 'item.dart';

//导航变化监听
typedef OnNavigationChange = void Function(int index);

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController extends BaseController {
  //记录当前选中下标
  final ValueChangeNotifier<int> _currentIndex;

  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  //导航子项集合
  final List<NavigationItem> items;

  JBottomNavigationController({
    required this.items,
    int initialIndex = 0,
  })  : _currentIndex = ValueChangeNotifier(initialIndex),
        _badges = MapValueChangeNotifier.empty();

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //选中一个下标
  void select(int index) {
    if (index < 0 || index > items.length) index = 0;
    _currentIndex.setValue(index);
  }

  //添加下标变化监听
  void addChangeListener(OnNavigationChange onChange) {
    _currentIndex.addListener(() => onChange(currentIndex));
    _badges.addListener(() => onChange(currentIndex));
  }

  //根据下标获取角标对象
  Widget? getBadge(int index) => _badges.value[index];

  //添加角标
  void addBadge(int index, JBadgeView badge) => _badges.putValue(index, badge);

  //移除角标
  void removeBadge(int index) => _badges.removeValue(index);

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    _badges.dispose();
    items.clear();
  }
}
