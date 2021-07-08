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
  Future<void> showLoading(
    BuildContext context, {
    WidgetBuilder? builder,
    Size loadingSize = const Size(85, 85),
  }) async {
    await hideLoadingDialog();
    loadingDialog = showDialog(
      context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.fromSize(
              size: loadingSize,
              child: (builder ?? _defLoading)(context),
            ),
          ],
        );
      },
    )..whenComplete(() => loadingDialog = null);
    return loadingDialog;
  }

  //构建默认加载框样式
  Widget _defLoading(BuildContext context) {
    return Card(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  //隐藏加载弹窗
  Future<void> hideLoadingDialog() async {
    if (null == loadingDialog) return;
    await jBase.router.pop();
  }
}
