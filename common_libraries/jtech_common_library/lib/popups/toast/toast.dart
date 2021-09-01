import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

import 'config.dart';

/*
* 消息提示
* @author wuxubaiyang
* @Time 2021/7/9 下午4:31
*/
class JToast extends BaseManage {
  static final JToast _instance = JToast._internal();

  factory JToast() => _instance;

  JToast._internal() : this._toast = FToast();

  //toast对象
  final FToast _toast;

  //显示toast
  void showToast(
    BuildContext context, {
    required ToastConfig config,
  }) {
    _toast.init(context);
    return _toast.showToast(
      child: _buildToastWidget(context, config),
      toastDuration: config.duration,
      gravity: _alignGravity[config.align],
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

//单例调用
final jToast = JToast();

//位置与重力转换表
final Map<Alignment, ToastGravity> _alignGravity = {
  Alignment.topCenter: ToastGravity.TOP,
  Alignment.topLeft: ToastGravity.TOP_LEFT,
  Alignment.topRight: ToastGravity.TOP_RIGHT,
  Alignment.center: ToastGravity.CENTER,
  Alignment.centerLeft: ToastGravity.CENTER_LEFT,
  Alignment.centerRight: ToastGravity.CENTER_RIGHT,
  Alignment.bottomCenter: ToastGravity.BOTTOM,
  Alignment.bottomLeft: ToastGravity.BOTTOM_LEFT,
  Alignment.bottomRight: ToastGravity.BOTTOM_RIGHT,
};
