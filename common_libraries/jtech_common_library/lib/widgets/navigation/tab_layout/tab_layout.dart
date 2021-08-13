import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 顶部分页导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:26
*/
class JTabLayout<T extends NavigationItem> extends BaseStatefulWidget {
  //控制器
  final JTabLayoutController<T> controller;

  //页面切换控制器
  final PageController pageController;

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
            PageController(initialPage: controller.currentIndex);

  @override
  _JTabLayoutState getState() => _JTabLayoutState();
}

/*
* tab导航状态
* @author wuxubaiyang
* @Time 2021/7/14 上午10:19
*/
class _JTabLayoutState extends BaseState<JTabLayout>
    with SingleTickerProviderStateMixin {
  //tab控制器
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    //初始化tab控制器
    tabController = TabController(
      length: widget.controller.itemLength,
      vsync: this,
      initialIndex: widget.controller.currentIndex,
    );
    //监听页码下标变化
    widget.controller.indexListenable.addListener(() {
      if (widget.controller.currentIndex !=
          widget.pageController.page?.round()) {
        widget.pageController.jumpToPage(widget.controller.currentIndex);
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
            controller: widget.pageController,
            physics: widget.canScroll ? null : NeverScrollableScrollPhysics(),
            children: List.generate(widget.controller.itemLength,
                (index) => widget.controller.getItem(index).page),
            onPageChanged: (index) {
              tabController.animateTo(index);
              widget.controller.select(index);
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
      color: widget.tabBarColor,
      elevation: widget.elevation,
      child: ValueListenableBuilder<int>(
        valueListenable: widget.controller.indexListenable,
        builder: (context, currentIndex, child) {
          return TabBar(
            controller: tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.black,
            isScrollable: !widget.isFixed,
            indicator: widget.indicatorConfig.decoration,
            indicatorColor: widget.indicatorConfig.color,
            indicatorPadding: widget.indicatorConfig.padding,
            indicatorWeight: widget.indicatorConfig.weight,
            indicatorSize: widget.indicatorConfig.sizeByTab
                ? TabBarIndicatorSize.tab
                : TabBarIndicatorSize.label,
            onTap: (index) {
              widget.pageController.jumpToPage(index);
              widget.controller.select(index);
            },
            tabs: List.generate(widget.controller.itemLength,
                (index) => _buildTabBarItem(index)),
          );
        },
      ),
    );
  }

  //构建tabBar子项
  _buildTabBarItem(int index) {
    var item = widget.controller.getItem(index);
    bool selected = index == widget.controller.currentIndex;
    return Container(
      height: widget.tabBarHeight,
      alignment: Alignment.center,
      child: JBadgeContainer(
        listenable: widget.controller.getBadgeListenable(index),
        align: widget.badgeAlign,
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
    widget.controller.dispose();
    widget.pageController.dispose();
    tabController.dispose();
  }
}
