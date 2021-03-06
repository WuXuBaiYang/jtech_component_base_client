import 'package:jtech_common_library/jcommon.dart';

/*
* 顶部tab导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 下午2:53
*/
class JTabLayoutController<T extends NavigationItem>
    extends BaseNavigationController<T> {
  JTabLayoutController({
    required List<T> items,
    int initialIndex = 0,
  }) : super(items: items, initialIndex: initialIndex);
}
