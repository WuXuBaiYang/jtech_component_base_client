import 'package:example/listview/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表格组件demo
* @author wuxubaiyang
* @Time 2021/7/20 下午2:49
*/
class GridviewDemo extends BaseStatelessPage {
  //控制器
  final JGridViewController<ListItemModel> controller;

  GridviewDemo()
      : this.controller = JGridViewController(
          dataList: List.generate(
              100,
              (i) => ListItemModel(
                    title: "测试数据 $i",
                    des: "这里是第 $i 条数据",
                    leading: Icons.home,
                  )),
        );

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "默认表格组件",
      body: JGridView.def<ListItemModel>(
        crossAxisCount: 5,
        staggeredTile: JStaggeredTile.fit(1),
        config: GridViewConfig(
          staggeredTileBuilder: (item, index) {
            if (index == 2) return null;
            if (index.isEven) return JStaggeredTile.fit(3);
            return JStaggeredTile.fit(2);
          },
        ),
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
        itemTap: (item, index) =>
            jCommon.popups.snack.showSnackInTime(context, text: "点击事件"),
        itemLongTap: (item, index) =>
            jCommon.popups.snack.showSnackInTime(context, text: "长点击事件"),
      ),
    );
  }
}
