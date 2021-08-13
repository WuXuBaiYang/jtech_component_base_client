import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'config.dart';

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
abstract class BaseNavigationController<T extends NavigationItem>
    extends BaseController with NavigationControllerBadge {
  //记录当前选中下标
  final ValueChangeNotifier<int> _currentIndex;

  //导航子项集合
  final List<T> _items;

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //获取下标监听对象
  ValueListenable<int> get indexListenable => _currentIndex;

  //获取数据长度
  int get itemLength => _items.length;

  BaseNavigationController({
    required List<T> items,
    int initialIndex = 0,
  })  : assert(initialIndex >= 0 && initialIndex < items.length, "初始下标超出数据范围"),
        this._items = items,
        _currentIndex = ValueChangeNotifier(initialIndex);

  //获取数据子项
  T getItem(int index) => _items[index];

  //选中一个下标
  void select(int index) {
    if (index < 0 || index >= itemLength) index = 0;
    _currentIndex.setValue(index);
  }

  @override
  void addListener(VoidCallback listener) {
    _currentIndex.addListener(listener);
    super.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    _items.clear();
    clearBadges();
  }
}

/*
* 导航控制器的角标方法
* @author jtechjh
* @Time 2021/8/13 4:22 下午
*/
mixin NavigationControllerBadge {
  //维护角标数据对象表
  final Map<int, ValueChangeNotifier<BadgeConfig>> _badges = {};

  //获取指定下标的角标监听对象
  ValueChangeNotifier<BadgeConfig> getBadgeListenable(int index) {
    if (!_badges.containsKey(index)) {
      _badges[index] = ValueChangeNotifier(BadgeConfig.empty);
    }
    return _badges[index]!;
  }

  //添加角标
  void addBadge(int index, BadgeConfig config) =>
      getBadgeListenable(index).setValue(config);

  //移除角标
  void removeBadge(int index) =>
      getBadgeListenable(index).setValue(BadgeConfig.empty);

  //清除所有数据
  void clearBadges() => _badges.clear();
}
