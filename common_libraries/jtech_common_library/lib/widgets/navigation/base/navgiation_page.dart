import 'package:jtech_base_library/base/base_stateful_widget.dart';

/*
* 导航页面持有基类
* @author wuxubaiyang
* @Time 2021/7/12 上午10:12
*/
abstract class NavigationPage extends BaseStatefulWidget {
  @override
  bool get wantKeepAlive => true;
}
