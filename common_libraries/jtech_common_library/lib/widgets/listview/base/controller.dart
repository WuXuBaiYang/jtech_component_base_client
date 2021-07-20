import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';

//数据过滤回调
typedef OnFilterListener<V> = bool Function(V item);

/*
* 列表控制器
* @author wuxubaiyang
* @Time 2021/7/5 上午10:26
*/
class JListViewController<V> extends BaseController {
  //持有列表数据
  ListValueChangeNotifier<V> _dataList;

  JListViewController({
    List<V> dataList = const [],
  }) : _dataList = ListValueChangeNotifier(dataList);

  //获取数据集合
  List<V> get dataList => _dataList.value;

  //获取数据变化监听
  ValueListenable<List<V>> get dataListenable => _dataList;

  //覆盖数据
  void setData(List<V> newData) {
    if (isFilterData) return;
    _dataList.setValue(newData);
  }

  //添加数据，insertIndex=-1时放置在队列末尾
  void addData(
    List<V> newData, {
    int insertIndex = -1,
    bool clearData = false,
  }) {
    if (isFilterData) return;
    if (clearData) _dataList.clear();
    if (insertIndex > 0 && insertIndex < _dataList.value.length) {
      _dataList.insertValue(newData, index: insertIndex);
    } else {
      _dataList.addValue(newData);
    }
  }

  //原始数据列表
  List<V>? _originDateList;

  //判断是否正在过滤数据状态中
  bool get isFilterData => null != _originDateList;

  //数据过滤
  void filter(OnFilterListener listener) {
    if (null == _originDateList) {
      _originDateList = _dataList.value;
    }
    List<V> tempList = [];
    for (V item in _originDateList!) {
      if (listener(item)) tempList.add(item);
    }
    _dataList.setValue(tempList);
  }

  //清除过滤内容
  void clearFilter() {
    if (null == _originDateList) return;
    _dataList.setValue(_originDateList!);
    _originDateList = null;
  }

  @override
  void dispose() {
    super.dispose();
    //销毁数据集合
    _originDateList?.clear();
    _dataList.dispose();
  }
}
