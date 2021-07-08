import 'dart:math';

import 'package:example/listview_demo/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/listview/jlistview_index.dart';
import 'package:jtech_common_library/widgets/listview/jlistview_refresh.dart';

/*
* 索引列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class IndexListViewDemo extends BasePage {
  final JIndexListViewController<IndexListItemModel> controller =
      JIndexListViewController();

  //测试用集合
  final List<String> testTag = [
    "!",
    "@",
    "#",
    "\$",
    "%",
    "^",
    "&",
    "*",
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M"
  ];

  @override
  void initState() {
    super.initState();
    //创建测试数据
    List<IndexListItemModel> testData = [];
    testData.addAll(List.generate(50, (i) {
      String title = "${testTag[Random().nextInt(testTag.length)]}测试数据 $i";
      return IndexListItemModel.create(
        title: title,
        des: "第 $i 条数据",
        leading: Icons.home,
        tag: title,
      );
    }));
    controller.setIndexData(testData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("索引列表测试"),
      ),
      body: JIndexListView<IndexListItemModel>(
        controller: controller,
        itemBuilder: (_, item, index) {
          return ListTile(
            leading: Icon(item.leading),
            title: Text(item.title),
            subtitle: Text(item.des),
          );
        },
        // susConfig: IndexListViewSusConfig(
        //   itemBuilder: (_, item, index) {
        //     return Container(
        //       width: 100,
        //       height: 100,
        //       color: Colors.green[400],
        //       child: Center(
        //         child: Text(item.tagIndex ?? ""),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
