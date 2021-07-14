import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/base/controller.dart';
import 'package:jtech_common_library/widgets/base/value_change_notifier.dart';

import 'item.dart';

//顶部tab导航变化监听
typedef OnTabChange = void Function(int index);

/*
* 顶部tab导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 下午2:53
*/
class JTabLayoutController extends BaseController {
  //tab导航子项集合
  final List<TabItem> items;

  //下标对象持有
  final ValueChangeNotifier<int> _currentIndex;

  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  JTabLayoutController({
    required this.items,
    int initialIndex = 0,
  })  : this._currentIndex = ValueChangeNotifier(initialIndex),
        _badges = MapValueChangeNotifier.empty();

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //选中下标
  void select(int index) {
    if (index < 0 || index > items.length) index = 0;
    _currentIndex.setValue(index);
  }

  //添加下标变化监听
  void addChangeListener(OnTabChange onChange) {
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
  dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    _badges.dispose();
    items.clear();
  }
}
