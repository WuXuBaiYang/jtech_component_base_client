import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/popups/jdialog.dart';
import 'package:jtech_common_library/widgets/popups/jsheet.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          optionItem: Text("操作"),
          optionTap: () => "option",
          cancelItem: Text("取消"),
          confirmItem: Text("确认"),
          confirmTapAsync: () => Future.delayed(Duration(seconds: 2))
              .then((value) => "confirmAsync"),
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
        cancelItem: Text("取消"),
        cancelTap: () => "取消操作",
        confirmItem: Text("确认"),
        confirmTap: () => "确认操作",
      );
      print(result);
    },
    "显示底部sheet": (BuildContext context) async {
      var result = await jCommon.popups.sheet.showCustomBottomSheet(
        context,
        config: CustomPopupSheetConfig(
          title: Text("底部弹出sheet"),
          cancelItem: Icon(Icons.close),
          cancelTap: () => "close",
          confirmItem: Text("确认"),
          sheetHeight: 250,
          confirmTapAsync: () =>
              Future.delayed(Duration(seconds: 2)).then((value) => "confirm"),
          content: Text(
            "底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet底部弹出sheet",
          ),
        ),
      );
      print(result);
    },
    "显示全屏sheet": (BuildContext context) async {
      var result = await jCommon.popups.sheet.showFullSheet(
        context,
        content: Text("全屏sheet"),
        config: CustomPopupSheetConfig(
          sheetColor: Colors.greenAccent,
        ),
      );
      print(result);
    },
    "显示定高sheet": (BuildContext context) async {
      var result = await jCommon.popups.sheet.showFixedBottomSheet(
        context,
        sheetHeight: 300,
        content: Text("固定高度sheet"),
        config: CustomPopupSheetConfig(
          sheetColor: Colors.redAccent,
        ),
      );
      print(result);
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹窗系统事件"),
        actions: [
          IconButton(
            icon: Text("test"),
            onPressed: () {
              jCommon.popups.toast.showShortToastTxt(
                context,
                text: "短toast测试",
                // color: Colors.greenAccent,
                // fontSize: 24,
              );
            },
          ),
        ],
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
