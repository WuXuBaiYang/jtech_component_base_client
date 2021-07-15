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
abstract class BaseNavigationController extends BaseController {
  //记录当前选中下标
  final ValueChangeNotifier<int> _currentIndex;

  //导航子项集合
  final List<NavigationItem> items;

  BaseNavigationController({
    required this.items,
    int initialIndex = 0,
  }) : _currentIndex = ValueChangeNotifier(initialIndex);

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
  }

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    items.clear();
  }
}
