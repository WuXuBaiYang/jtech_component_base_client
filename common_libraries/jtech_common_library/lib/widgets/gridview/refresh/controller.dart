import 'package:jtech_common_library/base/refresh/controller.dart';
import 'package:jtech_common_library/widgets/gridview/base/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 表格刷新组件控制器
* @author wuxubaiyang
* @Time 2021/7/20 下午4:52
*/
class JRefreshGridViewController<V> extends JGridViewController<V>
    with JRefreshControllerMixin<V> {
  //刷新控制器
  final RefreshController refreshController;

  JRefreshGridViewController({
    int? initPageIndex,
    int? pageSize,
    int? pageAddStep,
    bool initialRefresh = true,
  }) : this.refreshController =
            RefreshController(initialRefresh: initialRefresh) {
    super.initRefresh(
      initPageIndex: initPageIndex,
      pageSize: pageSize,
      pageAddStep: pageAddStep,
    );
    //监听刷新状态变化
    refreshListenable.addListener(() {
      switch (refreshState) {
        case RefreshState.refreshCompleted:
          return refreshController.refreshCompleted(resetFooterState: true);
        case RefreshState.refreshFailed:
          return refreshController.refreshFailed();
        case RefreshState.loadComplete:
          return refreshController.loadComplete();
        case RefreshState.loadFailed:
          return refreshController.loadFailed();
        case RefreshState.loadNoData:
          return refreshController.loadNoData();
        case RefreshState.none:
          return;
      }
    });
  }

  @override
  void addRefreshData(List<V> newData) => addData(newData);

  @override
  void setRefreshData(List<V> newData) => setData(newData);
}
