import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/badge/badge_container.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';

import 'config.dart';
import 'controller.dart';

/*
* 顶部分页导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:26
*/
class JTabLayout<T extends NavigationItem>
    extends BaseStatefulWidget<_JTabLayoutState> {
  //控制器
  final JTabLayoutController<T> controller;

  //页面切换控制器
  final PageController pageController;

  //状态管理
  final _JTabLayoutState _jTabLayoutState;

  //判断是否可滑动切换页面
  final bool canScroll;

  //tab导航栏颜色
  final Color tabBarColor;

  //tab导航栏高度
  final double tabBarHeight;

  //tab导航栏悬浮高度
  final double elevation;

  //导航栏tab是否可滚动
  final bool isFixed;

  //指示器配置对象
  final IndicatorConfig indicatorConfig;

  //角标对齐位置
  final Alignment badgeAlign;

  JTabLayout({
    required this.controller,
    this.canScroll = true,
    this.tabBarColor = Colors.transparent,
    this.elevation = 0,
    this.isFixed = true,
    this.tabBarHeight = 55,
    this.badgeAlign = Alignment.topRight,
    IndicatorConfig? indicatorConfig,
  })  : this.indicatorConfig = indicatorConfig ?? IndicatorConfig(),
        this.pageController =
            PageController(initialPage: controller.currentIndex),
        this._jTabLayoutState = _JTabLayoutState(
          length: controller.itemLength,
          initialIndex: controller.currentIndex,
        );

  @override
  _JTabLayoutState createState() => _jTabLayoutState;

  @override
  void initState() {
    super.initState();
    //监听页码下标变化
    controller.indexListenable.addListener(() {
      if (controller.currentIndex != pageController.page?.round()) {
        pageController.jumpToPage(controller.currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            children: List.generate(controller.itemLength,
                (index) => controller.getItem(index).page),
            onPageChanged: (index) {
              _jTabLayoutState.tabController.animateTo(index);
              controller.select(index);
            },
          ),
        ),
      ],
    );
  }

  //构建tab导航
  Widget _buildTabBar() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(),
      color: tabBarColor,
      elevation: elevation,
      child: ValueListenableBuilder<int>(
        valueListenable: controller.indexListenable,
        builder: (context, currentIndex, child) {
          return TabBar(
            controller: _jTabLayoutState._tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.black,
            isScrollable: !isFixed,
            indicator: indicatorConfig.decoration,
            indicatorColor: indicatorConfig.color,
            indicatorPadding: indicatorConfig.padding,
            indicatorWeight: indicatorConfig.weight,
            indicatorSize: indicatorConfig.sizeByTab
                ? TabBarIndicatorSize.tab
                : TabBarIndicatorSize.label,
            onTap: (index) {
              pageController.jumpToPage(index);
              controller.select(index);
            },
            tabs: List.generate(
                controller.itemLength, (index) => _buildTabBarItem(index)),
          );
        },
      ),
    );
  }

  //构建tabBar子项
  _buildTabBarItem(int index) {
    var item = controller.getItem(index);
    bool selected = index == controller.currentIndex;
    return Container(
      height: tabBarHeight,
      alignment: Alignment.center,
      child: JBadgeContainer(
        listenable: controller.getBadgeListenable(index)!,
        align: badgeAlign,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (selected ? item.activeImage : item.image) ?? EmptyBox(),
            (selected ? item.activeTitle : item.title) ?? EmptyBox(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁所有控制器
    controller.dispose();
    pageController.dispose();
    _jTabLayoutState.tabController.dispose();
  }
}

/*
* tab导航状态
* @author wuxubaiyang
* @Time 2021/7/14 上午10:19
*/
class _JTabLayoutState extends BaseStatefulWidgetState
    with SingleTickerProviderStateMixin {
  //tab控制器
  TabController? _tabController;

  _JTabLayoutState({required int length, int initialIndex = 0}) {
    _tabController = TabController(
      length: length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  //获取tab控制器
  TabController get tabController => _tabController!;
}
