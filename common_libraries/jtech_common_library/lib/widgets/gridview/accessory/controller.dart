import 'package:jtech_common_library/jcommon.dart';

/*
* 表格刷新组件控制器
* @author wuxubaiyang
* @Time 2021/7/20 下午4:52
*/
class JAccessoryGridViewController<V> extends JListViewController<V> {
  JAccessoryGridViewController({
    List<V>? dataList,
  }) : super(dataList: dataList ?? []);
}
