import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 顶部分页导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:26
*/
class JTabLayoutState<V extends NavigationItem>
    extends BaseJNavigationState<JTabLayoutController<V>, V>
    with SingleTickerProviderStateMixin {
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

  JTabLayoutState({
    this.tabBarColor = Colors.transparent,
    this.elevation = 0,
    this.isFixed = true,
    this.tabBarHeight = 55,
    this.badgeAlign = Alignment.topRight,
    IndicatorConfig? indicatorConfig,
  }) : this.indicatorConfig = indicatorConfig ?? IndicatorConfig();

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
      var currentIndex = widget.controller.currentIndex;
      if (currentIndex != tabController.index) {
        tabController.animateTo(currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(),
      color: tabBarColor,
      elevation: elevation,
      child: ValueListenableBuilder<int>(
        valueListenable: widget.controller.indexListenable,
        builder: (context, currentIndex, child) {
          return TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            isScrollable: !isFixed,
            indicator: indicatorConfig.decoration,
            indicatorColor: indicatorConfig.color,
            indicatorPadding: indicatorConfig.padding,
            indicatorWeight: indicatorConfig.weight,
            indicatorSize: indicatorConfig.sizeByTab
                ? TabBarIndicatorSize.tab
                : TabBarIndicatorSize.label,
            onTap: (index) => widget.controller.select(index),
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
      height: tabBarHeight,
      alignment: Alignment.center,
      child: JBadgeContainer(
        listenable: widget.controller.getBadgeListenable(index),
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
    //销毁控制器
    tabController.dispose();
  }
}
