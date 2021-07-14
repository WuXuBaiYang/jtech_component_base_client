import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tab_page.dart';
/*
* 顶部tab导航子项对象
* @author wuxubaiyang
* @Time 2021/7/12 下午2:55
*/
class TabItem {
  //内容视图，必须继承自tabPage
  TabPage page;

  //导航子项标题
  Widget? title;

  //选中状态子项标题
  Widget? activeTitle;

  //导航子项图片
  Widget? image;

  //选中状态子项图片
  Widget? activeImage;

  TabItem({
    required this.page,
    this.title,
    Widget? activeTitle,
    this.image,
    Widget? activeImage,
  })  : this.activeTitle = activeTitle ?? title,
        this.activeImage = activeImage ?? image;
}

/*
* 常用顶部导航子项对象
* @author wuxubaiyang
* @Time 2021/7/12 下午2:57
*/
class NormalTabItem extends TabItem {
  NormalTabItem({
    required TabPage page,
    String title = "",
    double fontSize = 14,
    Color titleColor = Colors.black,
    String? activeTitle,
    double? activeFontSize,
    Color? activeTitleColor,
    Widget? image,
    Widget? activeImage,
  }) : super(
    page: page,
    title: Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: titleColor,
      ),
    ),
    activeTitle: Text(
      activeTitle ?? title,
      style: TextStyle(
        fontSize: activeFontSize ?? fontSize,
        color: activeTitleColor ?? titleColor,
      ),
    ),
    image: image,
    activeImage: activeImage,
  );
}