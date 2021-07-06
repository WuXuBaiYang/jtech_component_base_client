import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/base/ValueChangeNotifier.dart';

//列表子项构造器
typedef ListItemBuilder<V> = Widget Function(
    BuildContext context, V? item, int index);
//列表分割线构造器
typedef ListDividerBuilder = Widget Function(BuildContext context, int index);

/*
* 列表基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:24
*/
abstract class BaseListView<T extends JListViewController<V>, V>
    extends BaseStatefulWidget {
  //列表控制器
  final T controller;

  //列表子项构造器
  final ListItemBuilder<V> itemBuilder;

  //列表分割线构造器
  final ListDividerBuilder? dividerBuilder;

  BaseListView({
    required this.controller,
    required this.itemBuilder,
    required this.dividerBuilder,
  });
}

//数据变化监听回调
typedef OnDateChangeListener<V> = void Function(List<V> dataList);

//数据搜索回调
typedef OnSearchListener<V> = bool Function(V item);

/*
* 列表控制器
* @author wuxubaiyang
* @Time 2021/7/5 上午10:26
*/
class JListViewController<V> {
  //分页-默认初始页面
  final int initPageIndex;

  //持有列表数据
  ValueChangeNotifier<List<V>> _dataList;

  //临时列表数据
  ValueChangeNotifier<List<V>> _tempDateList;

  //分页-页码
  int pageIndex;

  //分页-单页数据量
  int pageSize;

  JListViewController({
    this.initPageIndex = 0,
    this.pageSize = 15,
    List<V> dataList = const [],
  })  : pageIndex = initPageIndex,
        _dataList = ValueChangeNotifier(dataList),
        _tempDateList = ValueChangeNotifier([]);

  //获取数据集合
  List<V> get dataList => _dataList.value;

  //获取临时数据集合
  List<V> get tempDataList => _tempDateList.value;

  //页码增加
  void pageAdd({int addSize = 1}) => pageIndex += addSize;

  //页码减少
  void pageSub({int subSize = 1}) => pageIndex -= subSize;

  //获取数据长度
  int get dataLength => dataList.length;

  //获取列表子项
  V getItem(int index) => dataList[index];

  //注册监听数据变化
  void registerOnDataChange(OnDateChangeListener<V> listener) {
    _dataList.addListener(() {
      listener(_dataList.value);
    });
  }

  //注册监听临时数据变化
  void registerOnTempDataChange(OnDateChangeListener<V> listener) {
    _tempDateList.addListener(() {
      listener(_tempDateList.value);
    });
  }

  //放置数据，insertIndex=-1时放置在队列末尾
  void putData(
    List<V> data, {
    int insertIndex = -1,
    bool clearData = false,
  }) {
    if (clearData) _dataList.value.clear();
    if (insertIndex > 0 && insertIndex < _dataList.value.length) {
      _dataList.value.insertAll(insertIndex, data);
    } else {
      _dataList.value.addAll(data);
    }
    _dataList.update();
  }

  //数据搜索
  void search(OnSearchListener listener) {
    _tempDateList.value.clear();
    for (V item in _dataList.value) {
      if (listener(item)) _tempDateList.value.add(item);
    }
    _tempDateList.update();
  }
}
