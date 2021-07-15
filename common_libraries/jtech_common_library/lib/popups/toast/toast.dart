import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jtech_common_library/base/empty_box.dart';

import 'config.dart';

/*
* 消息提示
* @author wuxubaiyang
* @Time 2021/7/9 下午4:31
*/
@protected
class Toast {
  //toast对象
  final toast = FToast();

  //显示toast
  void showToast(
    BuildContext context, {
    required ToastConfig config,
  }) {
    toast.init(context);
    return toast.showToast(
      child: _buildToastWidget(context, config),
      toastDuration: config.duration,
      gravity: config.gravity,
    );
  }

  //显示长toast文本
  void showLongToastTxt(
    BuildContext context, {
    String text = "",
    Color color = Colors.white,
    double fontSize = 16,
    ToastConfig? config,
  }) {
    return showLongToast(
      context,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
      config: config,
    );
  }

  //显示短toast文本
  void showShortToastTxt(
    BuildContext context, {
    required String text,
    Color color = Colors.white,
    double fontSize = 16,
    ToastConfig? config,
  }) {
    return showShortToast(
      context,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
      config: config,
    );
  }

  //显示长时间toast
  void showLongToast(
    BuildContext context, {
    required Widget child,
    ToastConfig? config,
  }) {
    return showToast(
      context,
      config: (config ?? ToastConfig()).copyWith(
        duration: Duration(seconds: 5),
        child: child,
      ),
    );
  }

  //显示短时间toast
  void showShortToast(
    BuildContext context, {
    required Widget child,
    ToastConfig? config,
  }) {
    return showToast(
      context,
      config: (config ?? ToastConfig()).copyWith(
        duration: Duration(seconds: 2),
        child: child,
      ),
    );
  }

  //构建toast样式
  Widget _buildToastWidget(BuildContext context, ToastConfig config) {
    if (null != config.toastBuilder) {
      return config.toastBuilder!(context, config.child);
    }
    return Container(
      padding: config.padding,
      decoration: config.decoration,
      child: config.child ?? EmptyBox(),
    );
  }
}
