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

  //判断是否展示标题栏
  final bool showAppbar;

  //页面内容元素
  final Widget body;

  //标题，左侧元素
  final Widget? appBarLeading;

  //标题栏左侧按钮类型
  final AppBarLeading appBarLeadingType;

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
    this.showAppbar = true,
    this.appBarLeading,
    this.appBarLeadingType = AppBarLeading.back,
    this.appBarActions = const [],
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.floatingActionButtonAnimator,
  });

  //构建一个带有底部导航的页面组件
  static MaterialPageRoot withBottomNavigation<V extends NavigationItem>({
    //页面基本参数
    String appBarTitle = '',
    AppBar? appBar,
    bool showAppbar = true,
    Widget? appBarLeading,
    AppBarLeading appBarLeadingType = AppBarLeading.back,
    List<Widget> appBarActions = const [],
    Color? backgroundColor,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    //导航参数
    required JBottomNavigationController<V> controller,
    bool canScroll = false,
    Color navigationColor = Colors.white,
    double navigationHeight = 60,
    double elevation = 8,
    Alignment badgeAlign = Alignment.topRight,
    NotchLocation notchLocation = NotchLocation.none,
    double notchMargin = 4.0,
    NotchedShape notchedShape = const CircularNotchedRectangle(),
  }) {
    return MaterialPageRoot(
      appBarTitle: appBarTitle,
      appBar: appBar,
      showAppbar: showAppbar,
      appBarLeading: appBarLeading,
      appBarLeadingType: appBarLeadingType,
      appBarActions: appBarActions,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      body: JNavigation.pageView(
        controller: controller,
        canScroll: canScroll,
      ),
      bottomNavigationBar: JNavigation.bottomBar(
        controller: controller,
        navigationColor: navigationColor,
        navigationHeight: navigationHeight,
        elevation: elevation,
        badgeAlign: badgeAlign,
        notchLocation: notchLocation,
        notchMargin: notchMargin,
        notchedShape: notchedShape,
      ),
    );
  }

  //构建带有顶部导航的页面组件
  static MaterialPageRoot withTabLayout<V extends NavigationItem>({
    //页面基本参数
    String appBarTitle = '',
    bool showAppbar = true,
    Widget? appBarLeading,
    AppBarLeading appBarLeadingType = AppBarLeading.back,
    List<Widget> appBarActions = const [],
    Color? backgroundColor,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    //导航参数
    required JTabLayoutController<V> controller,
    bool canScroll = true,
    Color tabBarColor = Colors.transparent,
    double elevation = 0,
    bool isFixed = true,
    double tabBarHeight = 55,
    Alignment badgeAlign = Alignment.topRight,
    IndicatorConfig? indicatorConfig,
  }) {
    return MaterialPageRoot(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: appBarLeading ?? appBarLeadingType.leading,
        actions: appBarActions,
        bottom: JNavigation.tabBar(
          controller: controller,
          tabBarColor: tabBarColor,
          elevation: elevation,
          isFixed: isFixed,
          tabBarHeight: tabBarHeight,
          badgeAlign: badgeAlign,
          indicatorConfig: indicatorConfig,
        ),
      ),
      showAppbar: showAppbar,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      body: JNavigation.pageView(
        controller: controller,
        canScroll: canScroll,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar
          ? appBar ??
              AppBar(
                leading: appBarLeading ?? appBarLeadingType.leading,
                title: Text(appBarTitle),
                actions: appBarActions,
              )
          : null,
      body: body,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
    );
  }
}

/*
* 标题栏左侧按钮类型
* @author wuxubaiyang
* @Time 2021/8/15 0:37
*/
enum AppBarLeading {
  none,
  back,
  close,
}

/*
* 扩展标题栏左侧按钮类型枚举方法
* @author wuxubaiyang
* @Time 2021/8/15 0:40
*/
extension AppBarLeadingExtension on AppBarLeading {
  //获取leading组件
  Widget? get leading {
    switch (this) {
      case AppBarLeading.back:
        return BackButton();
      case AppBarLeading.close:
        return CloseButton();
      case AppBarLeading.none:
    }
    return null;
  }
}
