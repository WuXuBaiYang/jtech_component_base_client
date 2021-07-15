import 'package:example/listview_demo/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/listview/refresh/controller.dart';
import 'package:jtech_common_library/widgets/listview/refresh/listview_refresh.dart';

/*
* 可刷新列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class RefreshListViewDemo extends BasePage {
  final JRefreshListViewController<ListItemModel> controller =
      JRefreshListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("加载列表测试"),
      ),
      body: JRefreshListView<ListItemModel>(
        initialRefresh: true,
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
        onRefreshListViewLoad: _loadData,
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
