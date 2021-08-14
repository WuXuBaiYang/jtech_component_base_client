import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 基本列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class ListViewDemo extends BaseStatelessPage {
  //列表组件
  final Map<String, String> listviewMap = {
    "默认列表": "/test/listview/default",
    "刷新列表": "/test/listview/refresh",
    "索引列表": "/test/listview/index",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "列表组件demo",
      body: JListView.def<String>(
        dividerBuilder: (_, index) => Divider(),
        itemBuilder: (_, item, index) {
          return ListTile(
            title: Text(item),
            onTap: () => jRouter.pushNamed(listviewMap[item]!),
          );
        },
        controller: JListViewController(
          dataList: listviewMap.keys.toList(),
        ),
      ),
    );
  }
}
