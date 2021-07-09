import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

/*
* 消息提示
* @author wuxubaiyang
* @Time 2021/7/9 下午4:31
*/
class JToast {
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
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.black38,
      ),
      child: config.child ?? EmptyBox(),
    );
  }
}

//toast构建器
typedef ToastBuilder = Widget Function(BuildContext context, Widget? child);

/*
* toast配置信息
* @author wuxubaiyang
* @Time 2021/7/9 下午5:20
*/
class ToastConfig {
  //toast内容子项
  Widget? child;

  //构建toast背景视图
  ToastBuilder? toastBuilder;

  //toast时间
  Duration? duration;

  //toast位置
  Alignment? align;

  ToastConfig({
    this.toastBuilder,
    this.duration,
    this.align,
    this.child,
  });

  ToastConfig copyWith({
    ToastBuilder? toastBuilder,
    Duration? duration,
    Alignment? align,
    Widget? child,
  }) {
    return ToastConfig(
      toastBuilder: toastBuilder ?? this.toastBuilder,
      duration: duration ?? this.duration,
      align: align ?? this.align,
      child: child ?? this.child,
    );
  }

  //将align转换为toastGravity
  ToastGravity get gravity {
    //上
    if (Alignment.topCenter == align) return ToastGravity.TOP;
    if (Alignment.topLeft == align) return ToastGravity.TOP_LEFT;
    if (Alignment.topRight == align) return ToastGravity.TOP_RIGHT;
    //中
    if (Alignment.center == align) return ToastGravity.CENTER;
    if (Alignment.centerLeft == align) return ToastGravity.CENTER_LEFT;
    if (Alignment.centerRight == align) return ToastGravity.CENTER_RIGHT;
    //下
    if (Alignment.bottomCenter == align) return ToastGravity.BOTTOM;
    if (Alignment.bottomLeft == align) return ToastGravity.BOTTOM_LEFT;
    if (Alignment.bottomRight == align) return ToastGravity.BOTTOM_RIGHT;
    return ToastGravity.BOTTOM;
  }
}
