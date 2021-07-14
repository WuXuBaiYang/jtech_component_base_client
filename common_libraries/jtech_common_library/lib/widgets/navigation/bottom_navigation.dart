import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

import 'controller.dart';

/*
* 底部导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:13
*/
class JBottomNavigation extends BaseStatefulWidget {
  //底部导航控制器
  final JBottomNavigationController controller;

  //pageView控制器
  final PageController pageController;

  //判断是否可滑动切换页面
  final bool canScroll;

  //导航条颜色
  final Color navigationColor;

  //导航条高度
  final double navigationHeight;

  //导航条悬浮高度
  final double elevation;

  //角标显示位置
  final Alignment badgeAlign;

  JBottomNavigation({
    required this.controller,
    this.canScroll = false,
    this.navigationColor = Colors.white,
    this.navigationHeight = 60,
    this.elevation = 8,
    this.badgeAlign = Alignment.topRight,
  }) : pageController = PageController(
          initialPage: controller.currentIndex,
        );

  @override
  void initState() {
    super.initState();
    //监听页码变化
    controller.addChangeListener((index) => refreshUI(() {
          if (pageController.page?.round() != index) {
            pageController.jumpToPage(index);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) => controller.select(index),
            children: List.generate(controller.items.length,
                (index) => controller.items[index].page),
          ),
        ),
        _buildBottomNavigation(),
      ],
    );
  }

  //构建底部导航
  _buildBottomNavigation() {
    return Card(
      shape: RoundedRectangleBorder(),
      margin: EdgeInsets.zero,
      color: navigationColor,
      elevation: elevation,
      child: Container(
        height: navigationHeight,
        child: Row(
          children: List.generate(controller.items.length,
              (index) => _buildBottomNavigationItem(index)),
        ),
      ),
    );
  }

  //构建底部导航子项
  _buildBottomNavigationItem(int index) {
    bool selected = index == controller.currentIndex;
    var item = controller.items[index];
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (selected ? item.activeImage : item.image) ?? EmptyBox(),
                  (selected ? item.activeTitle : item.title) ?? EmptyBox(),
                ],
              ),
              onTap: () => controller.select(index),
            ),
          ),
          Align(
            alignment: badgeAlign,
            child: controller.getBadge(index),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    controller.dispose();
    pageController.dispose();
  }
}
