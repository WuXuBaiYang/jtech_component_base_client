import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表格组件demo
* @author wuxubaiyang
* @Time 2021/7/20 下午2:49
*/
class GridviewDemo extends BaseStatelessPage {
  //表格组件列表
  final Map<String, String> gridDemoMap = {
    "默认表格格": "/test/gridview/default",
    "刷新表格格": "/test/gridview/refresh",
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: '表格组件demo',
      body: JListView.def<String>(
        dividerBuilder: (_, index) => Divider(),
        itemBuilder: (_, item, index) {
          return ListTile(
            title: Text(item),
            onTap: () => jRouter.pushNamed(gridDemoMap[item]!),
          );
        },
        controller: JListViewController(
          dataList: gridDemoMap.keys.toList(),
        ),
      ),
    );
  }
}
