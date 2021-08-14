import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

import 'list_item_model.dart';

/*
* 基本列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class ListViewDemo extends BaseStatelessPage {
  //控制器
  final JListViewController<ListItemModel> controller;

  ListViewDemo()
      : this.controller = JListViewController(
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
      appBarTitle: "基本列表测试",
      body: JListView.def<ListItemModel>(
        controller: controller,
        dividerBuilder: (_, index) => Divider(),
        itemBuilder: (_, item, index) {
          return ListTile(
            leading: Icon(Icons.home),
            title: Text("测试数据"),
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
