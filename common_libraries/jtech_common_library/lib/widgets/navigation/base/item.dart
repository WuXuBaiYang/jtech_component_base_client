import 'dart:ui';
import 'package:flutter/material.dart';
import 'navgiation_page.dart';

/*
* 底部导航子项，包含页面视图
* @author wuxubaiyang
* @Time 2021/7/12 上午10:11
*/
class NavigationItem {
  //内容视图，必须继承自navigationPage
  NavigationPage page;

  //导航子项标题
  Widget? title;

  //选中状态子项标题
  Widget? activeTitle;

  //导航子项图片
  Widget? image;

  //选中状态子项图片
  Widget? activeImage;

  NavigationItem({
    required this.page,
    this.title,
    Widget? activeTitle,
    this.image,
    Widget? activeImage,
  })  : this.activeTitle = activeTitle ?? title,
        this.activeImage = activeImage ?? image;

  //文本子项
  NavigationItem.text({
    required this.page,
    String title = "",
    double fontSize = 14,
    Color titleColor = Colors.black,
    String? activeTitle,
    double? activeFontSize,
    Color? activeTitleColor,
    this.image,
    Widget? activeImage,
  })  : this.activeImage = activeImage ?? image,
        this.title = Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: titleColor,
          ),
        ),
        activeTitle = Text(
          activeTitle ?? title,
          style: TextStyle(
            fontSize: activeFontSize ?? fontSize,
            color: activeTitleColor ?? titleColor,
          ),
        );
}
