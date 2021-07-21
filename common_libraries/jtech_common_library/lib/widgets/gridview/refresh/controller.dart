import 'package:jtech_common_library/base/refresh/controller.dart';
import 'package:jtech_common_library/widgets/gridview/base/controller.dart';

/*
* 表格刷新组件控制器
* @author wuxubaiyang
* @Time 2021/7/20 下午4:52
*/
class JRefreshGridViewController<V> extends JGridViewController<V>
    with JRefreshControllerMixin<V> {
  JRefreshGridViewController({
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
