import 'package:jtech_common_library/base/refresh/controller.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';

/*
* 刷新列表组件控制器
* @author wuxubaiyang
* @Time 2021/7/7 上午11:25
*/
class JRefreshListViewController<V> extends JListViewController<V>
    with JRefreshControllerMixin<V> {
  JRefreshListViewController({
    int? initPageIndex,
    int? pageSize,
    int? pageAddStep,
  }) {
    super.create(
      initPageIndex: initPageIndex,
      pageSize: pageSize,
      pageAddStep: pageAddStep,
    );
  }

  @override
  void addRefreshData(List<V> newData) => addData(newData);

  @override
  void setRefreshData(List<V> newData) => setData(newData);
}
