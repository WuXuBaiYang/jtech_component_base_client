import 'package:example/listview_demo/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/controller.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/gridview_refresh.dart';

/*
* 表格刷新组件demo
* @author wuxubaiyang
* @Time 2021/7/20 下午2:49
*/
class GridviewRefreshDemo extends BasePage {
  //控制器
  final JRefreshGridViewController<ListItemModel> controller =
      JRefreshGridViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("表格组件demo"),
      ),
      body: JRefreshGridView<ListItemModel>(
        crossAxisCount: 5,
        initialRefresh: true,
        enablePullDown: true,
        enablePullUp: true,
        staggeredTile: JStaggeredTile.fit(1),
        staggeredTileBuilder: (item, index) {
          if (index == 2) return null;
          if (index.isEven) return JStaggeredTile.fit(3);
          return JStaggeredTile.fit(2);
        },
        controller: controller,
        onRefreshGridViewLoad: _loadData,
        itemBuilder: (BuildContext context, item, int index) {
          return Container(
            padding: EdgeInsets.all(15),
            color: Colors.blueAccent,
            child: CircleAvatar(
              child: Text("$index"),
              backgroundColor: Colors.white,
            ),
          );
        },
        itemTap: (item, index) {
          jCommon.popups.snack.showSnackInTime(context, text: "点击事件");
        },
        itemLongTap: (item, index) {
          jCommon.popups.snack.showSnackInTime(context, text: "长点击事件");
        },
      ),
    );
  }

  //加载数据
  Future<List<ListItemModel>> _loadData(int pageIndex, int pageSize) async {
    await Future.delayed(Duration(seconds: 1));
    // return [];
    throw Exception("aaa");
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
