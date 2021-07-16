import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/badge/config.dart';
import 'package:jtech_common_library/widgets/navigation/base/controller.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController<T extends NavigationItem>
    extends BaseNavigationController<T> {
  //维护角标数据对象表
  final Map<int, ValueChangeNotifier<BadgeConfig>> _badges = {};

  JBottomNavigationController({
    required List<T> items,
    int initialIndex = 0,
  })  : assert(initialIndex >= 0 && initialIndex < items.length, "初始下标超出数据范围"),
        super(
          items: items,
          initialIndex: initialIndex,
        );

  //获取指定下标的角标监听对象
  ValueChangeNotifier<BadgeConfig>? getBadgeListenable(int index) {
    if (isOverIndex(index)) return null;
    if (!_badges.containsKey(index)) {
      _badges[index] = ValueChangeNotifier(BadgeConfig.empty);
    }
    return _badges[index];
  }

  //添加角标
  void addBadge(int index, BadgeConfig config) =>
      getBadgeListenable(index)?.setValue(config);

  //移除角标
  void removeBadge(int index) =>
      getBadgeListenable(index)?.setValue(BadgeConfig.empty);

  @override
  dispose() {
    super.dispose();
    //销毁数据
    _badges.clear();
  }
}
