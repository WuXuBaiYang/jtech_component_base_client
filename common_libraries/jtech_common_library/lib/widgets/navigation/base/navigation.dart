import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/navigation/base/pageview/pageview.dart';

/*
* 导航组件
* @author wuxubaiyang
* @Time 2021/8/14 20:19
*/
class JNavigation<T extends BaseNavigationController<V>,
    V extends NavigationItem> extends BaseStatefulWidgetMultiply {
  //导航组件控制器
  final T controller;

  JNavigation({
    required State<JNavigation> currentState,
    required this.controller,
  }) : super(currentState: currentState);

  //构建顶部导航组件
  static PreferredSize tabBar<V extends NavigationItem>({
    required JTabLayoutController<V> controller,
    Color tabBarColor = Colors.transparent,
    double elevation = 0,
    bool isFixed = true,
    double tabBarHeight = 55,
    Alignment badgeAlign = Alignment.topRight,
    IndicatorConfig? indicatorConfig,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(tabBarHeight),
      child: JNavigation<JTabLayoutController<V>, V>(
        controller: controller,
        currentState: JTabLayoutState(
          tabBarColor: tabBarColor,
          elevation: elevation,
          isFixed: isFixed,
          tabBarHeight: tabBarHeight,
          badgeAlign: badgeAlign,
          indicatorConfig: indicatorConfig,
        ),
      ),
    );
  }

  //构建底部导航组件
  static PreferredSize bottomBar<V extends NavigationItem>({
    required JBottomNavigationController<V> controller,
    Color navigationColor = Colors.white,
    double navigationHeight = 60,
    double elevation = 8,
    Alignment badgeAlign = Alignment.topRight,
    NotchLocation notchLocation = NotchLocation.none,
    double notchMargin = 4.0,
    NotchedShape notchedShape = const CircularNotchedRectangle(),
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(navigationHeight),
      child: JNavigation<JBottomNavigationController<V>, V>(
        controller: controller,
        currentState: JBottomNavigationState(
          navigationColor: navigationColor,
          navigationHeight: navigationHeight,
          elevation: elevation,
          badgeAlign: badgeAlign,
          notchLocation: notchLocation,
          notchMargin: notchMargin,
          notchedShape: notchedShape,
        ),
      ),
    );
  }

  //导航通用页面管理组件
  static JNavigation pageView<T extends BaseNavigationController<V>,
      V extends NavigationItem>({
    required T controller,
    bool canScroll = true,
  }) {
    return JNavigation<T, V>(
      controller: controller,
      currentState: JNavigationPageView(
        canScroll: canScroll,
      ),
    );
  }
}

/*
* 导航组件状态基类
* @author wuxubaiyang
* @Time 2021/8/14 20:19
*/
abstract class BaseJNavigationState<T extends BaseNavigationController<V>,
    V extends NavigationItem> extends BaseState<JNavigation> {}
