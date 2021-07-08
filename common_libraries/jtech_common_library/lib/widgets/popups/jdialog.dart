import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* dialog弹窗管理
* @author wuxubaiyang
* @Time 2021/7/8 下午2:11
*/
class JDialog {
  //弹窗基础方法
  Future<T?> showDialog<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder: builder,
    );
  }

  //记录加载弹窗对象
  Future<void>? loadingDialog;

  //显示加载弹窗
  Future<void> showLoadingDialog(
    BuildContext context, {
    double hintSize = 85,
  }) async {
    await hideLoadingDialog();
    loadingDialog = showDialog(
      context,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.fromSize(
            size: Size(hintSize, hintSize),
            child: Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    )..whenComplete(() => loadingDialog = null);
    return loadingDialog;
  }

  //隐藏加载弹窗
  Future<void> hideLoadingDialog() async {
    if (null == loadingDialog) return;
    await jBase.router.pop();
  }
}
