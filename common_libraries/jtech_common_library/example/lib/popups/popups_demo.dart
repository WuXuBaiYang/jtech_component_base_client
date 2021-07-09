import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/popups/jdialog.dart';

/*
* 弹窗系统事件
* @author wuxubaiyang
* @Time 2021/7/8 下午2:57
*/
class PopupsDemo extends BasePage {
  //测试弹窗方法
  final Map<String, Function> testPopups = {
    "显示加载弹窗，3秒后关闭": (BuildContext context) async {
      jCommon.popups.dialog.showLoading(context);
      await Future.delayed(Duration(seconds: 3));
      jCommon.popups.dialog.hideLoadingDialog();
    },
    "显示自定义加载弹窗，3秒后关闭": (BuildContext context) async {
      jCommon.popups.dialog.showLoading(context, builder: (_) {
        return Card(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("自定义弹窗"),
            ],
          ),
        );
      });
      await Future.delayed(Duration(seconds: 3));
      jCommon.popups.dialog.hideLoadingDialog();
    },
    "显示弹窗": (BuildContext context) async {
      var result = await jCommon.popups.dialog.showCustomDialog<String>(
        context,
        config: CustomDialogConfig(
          //当设置为false时，点击事件的返回值为null则不会关闭dialog,用于拦截点击事件
          // nullToDismiss: false,
          title: Text("测试用标题"),
          titleIcon: Icon(Icons.home),
          content: Text("内容测试"),
          optionText: Text("操作"),
          optionTap: () {
            return "option";
          },
          cancelText: Text("取消"),
          confirmText: Text("确认"),
          confirmTapAsync: () async {
            await Future.delayed(Duration(seconds: 2));
            return "confirm";
          },
        ),
      );
      print(result);
    },
    "显示警告弹窗": (BuildContext context) async {
      var result = await jCommon.popups.dialog.showAlertDialog<String>(
        context,
        title: Text("测试用标题"),
        titleIcon: Icon(Icons.home),
        content: Text("内容测试"),
        cancelText: Text("取消"),
        cancelTap: () => "取消操作",
        confirmText: Text("确认"),
        confirmTap: () => "确认操作",
      );
      print(result);
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
