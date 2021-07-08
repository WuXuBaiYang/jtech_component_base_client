import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 弹窗系统事件
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class PopupsDemo extends BasePage {
  //测试弹窗方法
  final Map<String, Function> testPopups = {
    "显示加载弹窗，3秒后关闭": (BuildContext context) async {
      jCommon.popups.dialog.showLoadingDialog(context);
      await Future.delayed(Duration(seconds: 3));
      jCommon.popups.dialog.hideLoadingDialog();
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹窗系统事件"),
      ),
      body: ListView.separated(
        itemCount: testPopups.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(testPopups.keys.elementAt(index)),
            onTap: () {
              testPopups.values.elementAt(index).call(context);
            },
          );
        },
      ),
    );
  }
}
