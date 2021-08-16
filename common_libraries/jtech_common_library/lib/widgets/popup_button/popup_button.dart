import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

//弹层结果回调
typedef OnPopupCallback<T> = void Function(T? result);

/*
* 自定义弹层的按钮
* @author jtechjh
* @Time 2021/8/16 2:21 下午
*/
class JPopupButton extends BaseStatefulWidget {
  //按钮组件对象
  final Widget button;

  JPopupButton({
    required GlobalKey key,
    required this.button,
  }) : super(key: key);

  //构建一个图标按钮
  static JPopupButton icon<T>(
    BuildContext context, {
    required Widget icon,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    double iconSize = 24,
    Color? color,
    //弹窗相关配置
    required OverlayBuilder<T> builder,
    required Size size,
    OverlayConfig? popupConfig,
    OnPopupCallback<T>? onPopupDismiss,
  }) {
    var key = GlobalKey();
    return JPopupButton(
      key: key,
      button: IconButton(
        icon: icon,
        padding: padding,
        iconSize: iconSize,
        color: color,
        onPressed: () => _showPopup(
          context,
          key: key,
          size: size,
          builder: builder,
          config: popupConfig,
          onPopupDismiss: onPopupDismiss,
        ),
      ),
    );
  }

  //构建一个文本按钮
  static JPopupButton text<T>(
    BuildContext context, {
    required Widget child,
    ButtonStyle? style,
    //弹窗相关配置
    required OverlayBuilder<T> builder,
    required Size size,
    OverlayConfig? config,
    OnPopupCallback<T>? onPopupDismiss,
  }) {
    var key = GlobalKey();
    return JPopupButton(
      key: key,
      button: TextButton(
        child: child,
        style: style,
        onPressed: () => _showPopup(
          context,
          key: key,
          size: size,
          builder: builder,
          config: config,
          onPopupDismiss: onPopupDismiss,
        ),
      ),
    );
  }

  //展示自定义弹层
  static void _showPopup<T>(
    BuildContext context, {
    required GlobalKey key,
    required OverlayBuilder<T> builder,
    OverlayConfig? config,
    OnPopupCallback<T>? onPopupDismiss,
    Size size = Size.zero,
  }) {
    jOverlay
        .showByKey<T>(
          context,
          key: key,
          overlaySize: size,
          builder: builder,
          config: config,
        )
        .then((value) => onPopupDismiss?.call(value));
  }

  @override
  BaseState<StatefulWidget> getState() => _JPopupButtonState();
}

/*
* 自定义弹层按钮组件
* @author jtechjh
* @Time 2021/8/16 2:46 下午
*/
class _JPopupButtonState extends BaseState<JPopupButton> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: widget.button,
      onWillPop: () async {
        jOverlay.removeOverlay([widget.key!]);
        return true;
      },
    );
  }
}
