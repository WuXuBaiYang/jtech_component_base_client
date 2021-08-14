import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

import 'list_item_model.dart';

/*
* 可刷新列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class RefreshListViewDemo extends BaseStatelessPage {
  //控制器
  final JRefreshListViewController<ListItemModel> controller;

  RefreshListViewDemo() : this.controller = JRefreshListViewController();

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "加载列表测试",
      body: JListView.refresh<ListItemModel>(
        enablePullDown: true,
        enablePullUp: true,
        controller: controller,
        itemBuilder: (_, item, index) {
          return ListTile(
            leading: Icon(item.leading),
            title: Text(item.title),
            subtitle: Text(item.des),
          );
        },
        onRefreshLoad: _loadData,
      ),
    );
  }

  //加载数据
  Future<List<ListItemModel>> _loadData(int pageIndex, int pageSize) async {
    await Future.delayed(Duration(seconds: 1));
    // return [];
    // throw Exception("aaa");
    if (pageIndex > 3) return [];
    List<ListItemModel> testData = [];
    testData.addAll(List.generate(pageSize, (i) {
      return ListItemModel(
        title: "测试数据 $i",
        des: "这里是第 $pageIndex 页的第 $i 条数据",
        leading: Icons.home,
      );
    }));
    return testData;
  }
}
