import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';

import 'item.dart';

//导航变化监听
typedef OnNavigationChange = void Function(int index);

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
abstract class BaseNavigationController<T extends NavigationItem>
    extends BaseController {
  //记录当前选中下标
  final ValueChangeNotifier<int> _currentIndex;

  //导航子项集合
  final List<T> _items;

  BaseNavigationController({
    required List<T> items,
    int initialIndex = 0,
  })  : assert(initialIndex >= 0 && initialIndex < items.length, "初始下标超出数据范围"),
        this._items = items,
        _currentIndex = ValueChangeNotifier(initialIndex);

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //获取下标监听对象
  ValueListenable<int> get indexListenable => _currentIndex;

  //获取数据长度
  int get itemLength => _items.length;

  //获取数据子项
  T getItem(int index) => _items[index];

  //选中一个下标
  void select(int index) {
    if (isOverIndex(index)) index = 0;
    _currentIndex.setValue(index);
  }

  //判断下标是否越界
  bool isOverIndex(int index) => index < 0 || index >= _items.length;

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    _items.clear();
  }
}
