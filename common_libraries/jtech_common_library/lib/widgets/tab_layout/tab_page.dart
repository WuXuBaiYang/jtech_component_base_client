import 'package:jtech_base_library/base/base_stateful_widget.dart';

/*
* tab导航页面基类
* @author wuxubaiyang
* @Time 2021/7/12 下午2:53
*/
abstract class TabPage extends BaseStatefulWidget {
  @override
  bool get wantKeepAlive => true;
}
