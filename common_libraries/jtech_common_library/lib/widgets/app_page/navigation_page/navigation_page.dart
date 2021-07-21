import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/config.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/badge/badge_container.dart';
import 'package:jtech_common_library/widgets/navigation/base/item.dart';
import 'controller.dart';

/*
* 底部导航页面组件
* @author wuxubaiyang
* @Time 2021/7/21 下午4:13
*/
class BottomNavigationPage<T extends NavigationItem>
    extends BaseStatefulWidget {
  //页面主体配置参数
  final MaterialRootPageConfig pageConfig;

  //标题组件
  final PreferredSizeWidget? appBar;

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

  BottomNavigationPage({
    //页面部分参数
    required String appBarTitle,
    this.appBar,
    Widget? appBarLeading,
    List<Widget>? appBarActions,
    Color? backgroundColor,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    MaterialRootPageConfig? pageConfig,
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
  })  : pageController = PageController(initialPage: controller.currentIndex),
        this.pageConfig = (pageConfig ?? MaterialRootPageConfig()).copyWith(
          appBarTitle: appBarTitle,
          appBarLeading: appBarLeading,
          appBarActions: appBarActions,
          backgroundColor: backgroundColor,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
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
    return MaterialRootPage(
      appBar: appBar,
      appBarTitle: pageConfig.appBarTitle,
      config: pageConfig,
      body: PageView(
        physics: canScroll ? null : NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) => controller.select(index),
        children: List.generate(
          controller.itemLength,
          (index) => controller.getItem(index).page,
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  //构建底部导航
  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: elevation,
      color: navigationColor,
      shape: notchedShape,
      notchMargin: notchMargin,
      child: Container(
        height: navigationHeight,
        child: ValueListenableBuilder<int>(
          valueListenable: controller.indexListenable,
          builder: (context, currentIndex, child) {
            var bottomBars = List<Widget>.generate(
              controller.itemLength,
              (index) => _buildBottomBarItem(
                  controller.getItem(index), index == currentIndex, index),
            );
            if (notchLocation != NotchLocation.none) {
              int notchIndex = 0;
              if (notchLocation == NotchLocation.end) {
                notchIndex = controller.itemLength;
              } else if (notchLocation == NotchLocation.center) {
                notchIndex = controller.itemLength ~/ 2;
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
  _buildBottomBarItem(T item, bool selected, int index) {
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
