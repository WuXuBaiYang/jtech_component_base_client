import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

import 'list_item_model.dart';

/*
* 索引列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class IndexListViewDemo extends BaseStatelessPage {
  //控制器
  final JIndexListViewController<IndexListItemModel> controller;

  //测试用集合
  static final List<String> testTag = [
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

  IndexListViewDemo()
      : this.controller = JIndexListViewController()
          ..setData(
            List.generate(10, (i) {
              String title =
                  "${testTag[Random().nextInt(testTag.length)]}测试数据 $i";
              return IndexListItemModel.create(
                title: title,
                des: "第 $i 条数据",
                leading: Icons.home,
                tag: title,
              );
            }),
          );

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "索引列表测试",
      body: JListView.index<IndexListItemModel>(
        controller: controller,
        itemBuilder: (_, item, index) {
          return ListTile(
            leading: Icon(item.leading),
            title: Text(item.title),
            subtitle: Text(item.des),
          );
        },
      ),
    );
  }
}
