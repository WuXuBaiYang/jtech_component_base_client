import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 底部导航页面组件
* @author wuxubaiyang
* @Time 2021/7/21 下午4:13
*/
class JBottomNavigation<T extends NavigationItem>
    extends BaseStatefulWidget {
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

  //notch的显示位置
  final NotchLocation notchLocation;

  //notch外间距
  final double notchMargin;

  //notch形状样式
  final NotchedShape notchedShape;

  JBottomNavigation({
    //导航部分参数
    required this.controller,
    this.canScroll = false,
    this.navigationColor = Colors.white,
    this.navigationHeight = 60,
    this.elevation = 8,
    this.badgeAlign = Alignment.topRight,
    this.notchLocation = NotchLocation.none,
    this.notchMargin = 4.0,
    this.notchedShape = const CircularNotchedRectangle(),
  }) : pageController = PageController(initialPage: controller.currentIndex);

  @override
  _JBottomNavigationPageState getState() => _JBottomNavigationPageState();
}

/*
* 底部导航组件状态
* @author jtechjh
* @Time 2021/8/13 10:42 上午
*/
class _JBottomNavigationPageState extends BaseState<JBottomNavigation> {
  @override
  void initState() {
    super.initState();
    //监听页码变化
    widget.controller.indexListenable.addListener(() {
      if (widget.controller.currentIndex !=
          widget.pageController.page?.round()) {
        widget.pageController.jumpToPage(widget.controller.currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: widget.elevation,
      color: widget.navigationColor,
      shape: widget.notchedShape,
      notchMargin: widget.notchMargin,
      child: Container(
        height: widget.navigationHeight,
        child: ValueListenableBuilder<int>(
          valueListenable: widget.controller.indexListenable,
          builder: (context, currentIndex, child) {
            var bottomBars = List<Widget>.generate(
              widget.controller.itemLength,
                  (index) => _buildBottomBarItem(widget.controller.getItem(index),
                  index == currentIndex, index),
            );
            if (widget.notchLocation != NotchLocation.none) {
              int notchIndex = 0;
              if (widget.notchLocation == NotchLocation.end) {
                notchIndex = widget.controller.itemLength;
              } else if (widget.notchLocation == NotchLocation.center) {
                notchIndex = widget.controller.itemLength ~/ 2;
              }
              bottomBars.insert(notchIndex, Expanded(child: EmptyBox()));
            }
            return Row(children: bottomBars);
          },
        ),
      ),
    );
  }

  //构建底部导航子项
  _buildBottomBarItem(NavigationItem item, bool selected, int index) {
    return Expanded(
      child: JBadgeContainer(
        listenable: widget.controller.getBadgeListenable(index),
        align: widget.badgeAlign,
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
            widget.pageController.jumpToPage(index);
            widget.controller.select(index);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
    widget.pageController.dispose();
  }
}

/*
* notch所在位置
* @author wuxubaiyang
* @Time 2021/7/21 下午5:26
*/
enum NotchLocation {
  start,
  end,
  center,
  none,
}
