import 'package:jtech_common_library/jcommon.dart';

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController<T extends NavigationItem>
    extends BaseNavigationController<T> {
  JBottomNavigationController({
    required List<T> items,
    int initialIndex = 0,
  }) : super(items: items, initialIndex: initialIndex);
}
