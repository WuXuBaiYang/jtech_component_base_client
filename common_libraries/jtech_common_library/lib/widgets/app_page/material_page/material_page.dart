import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* material风格的页面根节点
* @author wuxubaiyang
* @Time 2021/7/21 下午2:36
*/
class MaterialPageRoot extends BaseStatelessWidget {
  //标题组件
  final PreferredSizeWidget? appBar;

  //页面内容元素
  final Widget body;

  //标题，左侧元素
  final Widget? appBarLeading;

  //标题文本
  final String appBarTitle;

  //标题动作元素集合
  final List<Widget> appBarActions;

  //背景色
  final Color? backgroundColor;

  //底部导航栏组件
  final Widget? bottomNavigationBar;

  //fab按钮组件
  final Widget? floatingActionButton;

  //fab按钮位置
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  //fab按钮动画
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  MaterialPageRoot({
    required this.body,
    this.appBarTitle = '',
    this.appBar,
    this.appBarLeading,
    this.appBarActions = const [],
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.floatingActionButtonAnimator,
  });

  //构建一个带有底部导航的页面组件
  MaterialPageRoot.bottomBar({
    //页面基本参数
    required this.body,
    this.appBarTitle = '',
    this.appBar,
    this.appBarLeading,
    this.appBarActions = const [],
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    //底部导航参数
    required JBottomNavigationController controller,
    bool canScroll = false,
    Color navigationColor = Colors.white,
    double navigationHeight = 60,
    double elevation = 8,
    Alignment badgeAlign = Alignment.topRight,
    NotchLocation notchLocation = NotchLocation.none,
    double notchMargin = 4.0,
    NotchedShape notchedShape = const CircularNotchedRectangle(),
  }) : this.bottomNavigationBar = JBottomNavigation(
          controller: controller,
          canScroll: canScroll,
          navigationColor: navigationColor,
          navigationHeight: navigationHeight,
          elevation: elevation,
          badgeAlign: badgeAlign,
          notchLocation: notchLocation,
          notchMargin: notchMargin,
          notchedShape: notchedShape,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          AppBar(
            leading: appBarLeading,
            title: Text(appBarTitle),
            actions: appBarActions,
          ),
      body: body,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
    );
  }
}
