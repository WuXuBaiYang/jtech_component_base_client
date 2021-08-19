import 'package:flutter/widgets.dart';

/*
* 菜单子项
* @author jtechjh
* @Time 2021/8/19 10:29 上午
*/
class MenuItem {
  //标题
  final Widget title;

  //副标题
  final Widget? subTitle;

  //头部图标
  final Widget? leading;

  //尾部图标
  final Widget? trailing;

  //点击事件
  final GestureTapCallback? onTap;

  //长点击事件
  final GestureLongPressCallback? onLongPress;

  MenuItem({
    required this.title,
    this.subTitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });
}
