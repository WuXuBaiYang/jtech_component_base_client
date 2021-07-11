import 'package:example/listview_demo/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/listview/base_listView.dart';
import 'package:jtech_common_library/widgets/listview/jlistview.dart';

/*
* 基本列表demo
* @author wuxubaiyang
* @Time 2021/7/6 下午2:17
*/
class ListViewDemo extends BasePage {
  final JListViewController<ListItemModel> controller = JListViewController();

  @override
  void initState() {
    super.initState();
    //生成测试数据
    Future.delayed(Duration(seconds: 3)).then((value) {
      List<ListItemModel> testData = [];
      testData.addAll(List.generate(100, (i) {
        return ListItemModel(
          title: "测试数据 $i",
          des: "这里是第 $i 条数据",
          leading: Icons.home,
        );
      }));
      controller.setData(testData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("基本列表测试"),
      ),
      body: JListView<ListItemModel>(
        controller: controller,
        itemBuilder: (_, item, index) {
          return ListTile(
            leading: Icon(Icons.home),
            title: Text("测试数据"),
          );
        },
      ),
    );
  }
}
