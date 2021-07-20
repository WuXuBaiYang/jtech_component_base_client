import 'package:example/listview_demo/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/gridview/base/controller.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';
import 'package:jtech_common_library/widgets/gridview/gridview.dart';

/*
* 表格组件demo
* @author wuxubaiyang
* @Time 2021/7/20 下午2:49
*/
class GridviewDemo extends BasePage {
  //控制器
  final JGridViewController<ListItemModel> controller = JGridViewController();

  @override
  void initState() {
    super.initState();
    //加载表格数据
    List<ListItemModel> testData = [];
    testData.addAll(List.generate(100, (i) {
      return ListItemModel(
        title: "测试数据 $i",
        des: "这里是第 $i 条数据",
        leading: Icons.home,
      );
    }));
    controller.setData(testData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("表格组件demo"),
      ),
      body: JGridView<ListItemModel>(
        crossAxisCount: 5,
        staggeredTile: JStaggeredTile.fit(1),
        staggeredTileBuilder: (item, index) {
          if (index == 2) return null;
          if (index.isEven) return JStaggeredTile.fit(3);
          return JStaggeredTile.fit(2);
        },
        controller: controller,
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
}
