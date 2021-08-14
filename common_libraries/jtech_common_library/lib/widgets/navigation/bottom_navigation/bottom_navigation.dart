import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 底部导航页面组件
* @author wuxubaiyang
* @Time 2021/7/21 下午4:13
*/
class JBottomNavigationState<V extends NavigationItem>
    extends BaseJNavigationState<JBottomNavigationController<V>, V> {
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

  JBottomNavigationState({
    this.navigationColor = Colors.white,
    this.navigationHeight = 60,
    this.elevation = 8,
    this.badgeAlign = Alignment.topRight,
    this.notchLocation = NotchLocation.none,
    this.notchMargin = 4.0,
    this.notchedShape = const CircularNotchedRectangle(),
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: elevation,
      color: navigationColor,
      shape: notchedShape,
      notchMargin: notchMargin,
      child: Container(
        height: navigationHeight,
        child: ValueListenableBuilder<int>(
          valueListenable: widget.controller.indexListenable,
          builder: (context, currentIndex, child) {
            var bottomBars = List<Widget>.generate(
              widget.controller.itemLength,
              (index) => _buildBottomBarItem(widget.controller.getItem(index),
                  index == currentIndex, index),
            );
            if (notchLocation != NotchLocation.none) {
              int notchIndex = 0;
              if (notchLocation == NotchLocation.end) {
                notchIndex = widget.controller.itemLength;
              } else if (notchLocation == NotchLocation.center) {
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
          onTap: () => widget.controller.select(index),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
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
