import 'package:jtech_common_library/jcommon.dart';

/*
* 表格刷新组件控制器
* @author wuxubaiyang
* @Time 2021/7/20 下午4:52
*/
class JRefreshGridViewController<V> extends JRefreshListViewController<V> {
  JRefreshGridViewController({
    int initPageIndex = 1,
    int pageIndex = 1,
    int pageAddStep = 1,
    int pageSize = 15,
    bool initialRefresh = true,
  }) : super(
          initPageIndex: initPageIndex,
          pageIndex: pageIndex,
          pageAddStep: pageAddStep,
          pageSize: pageSize,
          initialRefresh: initialRefresh,
        );
}
