import 'package:azlistview/azlistview.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';

import 'model.dart';
/*
* 索引列表组件控制器
* @author wuxubaiyang
* @Time 2021/7/8 上午9:26
*/
class JIndexListViewController<V extends BaseIndexModel>
    extends JListViewController<V> {
  //设置索引数据并自动排序
  void setIndexData(List<V> newData) {
    SuspensionUtil.sortListBySuspensionTag(newData);
    SuspensionUtil.setShowSuspensionStatus(newData);
    super.setData(newData);
  }

  //获取索引条数据集合
  List<String> get indexDataList => SuspensionUtil.getTagIndexList(dataList);

  @override
  @protected
  void setData(List<V> newData) => throw Exception("索引组件禁止调用该方法");

  @override
  @protected
  void addData(List<V> newData,
      {int insertIndex = -1, bool clearData = false}) =>
      throw Exception("索引组件禁止调用该方法");

  @override
  @protected
  void filter(OnFilterListener listener) => throw Exception("索引组件禁止调用该方法");

  @override
  @protected
  void clearFilter() => throw Exception("索引组件禁止调用该方法");
}