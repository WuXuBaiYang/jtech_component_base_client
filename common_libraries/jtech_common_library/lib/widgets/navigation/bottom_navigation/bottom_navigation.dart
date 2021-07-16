import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/badge/badge_container.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';
import 'controller.dart';

/*
* 底部导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:13
*/
class JBottomNavigation<T extends NavigationItem> extends BaseStatefulWidget {
  //底部导航控制器
  final JBottomNavigationController<T> controller;

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
        Expanded(
          child: PageView(
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) => controller.select(index),
            children: List.generate(controller.itemLength,
                (index) => controller.getItem(index).page),
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
        child: ValueListenableBuilder<int>(
          valueListenable: controller.indexListenable,
          builder: (context, currentIndex, child) {
            return Row(
              children: List.generate(
                controller.itemLength,
                (index) => _buildBottomNavigationItem(
                  controller.getItem(index),
                  index == currentIndex,
                  index,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //构建底部导航子项
  _buildBottomNavigationItem(T item, bool selected, int index) {
    return Expanded(
      child: JBadgeContainer(
        listenable: controller.getBadgeListenable(index)!,
        align: badgeAlign,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              (selected ? item.activeImage : item.image) ?? EmptyBox(),
              (selected ? item.activeTitle : item.title) ?? EmptyBox(),
            ],
          ),
          onTap: () {
            pageController.jumpToPage(index);
            controller.select(index);
          },
        ),
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
