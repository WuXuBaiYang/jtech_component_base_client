import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    required Widget child,
    ToastConfig? config,
  }) {
    toast.init(context);
    return toast.showToast(
      child: child,
      toastDuration: config?.duration,
      gravity: config?.gravity,
    );
  }

  //显示长toast文本
  void showLongToastTxt(
    BuildContext context, {
    String text = "",
    Color? color,
    double? fontSize,
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

  //显示长时间toast
  void showLongToast(
    BuildContext context, {
    required Widget child,
    ToastConfig? config,
  }) {
    return showToast(
      context,
      child: child,
      config: (config ?? ToastConfig()).copyWith(
        duration: Duration(seconds: 5),
      ),
    );
  }

  //显示短toast文本
  void showShortToastTxt(
    BuildContext context, {
    required String text,
    Color? color,
    double? fontSize,
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

  //显示短时间toast
  void showShortToast(
    BuildContext context, {
    required Widget child,
    ToastConfig? config,
  }) {
    return showToast(
      context,
      child: child,
      config: (config ?? ToastConfig()).copyWith(
        duration: Duration(seconds: 2),
      ),
    );
  }

  //构建默认toast背景
  Widget _buildDefToastBackground(Widget child) {
    return Container(
      child: child,
    );
  }
}

/*
* toast配置信息
* @author wuxubaiyang
* @Time 2021/7/9 下午5:20
*/
class ToastConfig {
  //构建toast背景视图
  WidgetBuilder? backgroundBuilder;

  //toast时间
  Duration? duration;

  //toast位置
  Alignment? align;

  ToastConfig({
    this.backgroundBuilder,
    this.duration,
    this.align,
  });

  ToastConfig copyWith({
    WidgetBuilder? backgroundBuilder,
    Duration? duration,
    Alignment? align,
  }) {
    return ToastConfig(
      backgroundBuilder: backgroundBuilder ?? this.backgroundBuilder,
      duration: duration ?? this.duration,
      align: align ?? this.align,
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
