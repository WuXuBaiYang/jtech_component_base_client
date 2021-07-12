import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/base/ValueChangeNotifier.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';

import 'navgiation_page.dart';

/*
* 底部导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:13
*/
class JBottomNavigation extends BaseStatefulWidget {
  //底部导航控制器
  final JBottomNavigationController controller;

  //初始下标
  final int initIndex;

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
    JBottomNavigationController? controller,
    required List<NavigationItem> items,
    int initIndex = 0,
    this.canScroll = false,
    this.navigationColor = Colors.white,
    this.navigationHeight = 60,
    this.elevation = 8,
    this.badgeAlign = Alignment.topRight,
  })  : this.controller = controller ?? JBottomNavigationController(),
        this.initIndex =
            (initIndex < 0 || initIndex > items.length) ? 0 : initIndex {
    this.controller.setItems(items);
  }

  @override
  void initState() {
    super.initState();
    //刷新初始下标
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.pageController.jumpToPage(initIndex);
    });
    //监听页码变化
    controller.addChangeListener((index) => refreshUI());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (index) => controller.updateIndex(index),
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
          children: List.generate(controller.items.length, (index) {
            var item = controller.items[index];
            bool selected = index == controller.currentIndex;
            return Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (selected ? item.activeImage : item.image) ??
                              EmptyBox(),
                          (selected ? item.activeTitle : item.title) ??
                              EmptyBox(),
                        ],
                      ),
                      onTap: () => controller.pageController.jumpToPage(index),
                    ),
                  ),
                  Align(
                    alignment: badgeAlign,
                    child: controller.getBadge(index),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

//导航变化监听
typedef OnNavigationChange = void Function(int index);

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController {
  //管理维护pageView控制器
  @protected
  final PageController pageController;

  //记录当前选中下标
  ValueChangeNotifier<int> _currentIndex;

  //导航子项集合
  final List<NavigationItem> items = [];

  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  JBottomNavigationController()
      : _currentIndex = ValueChangeNotifier(0),
        _badges = MapValueChangeNotifier({}),
        pageController = PageController();

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //设置底部导航子项集合
  void setItems(List<NavigationItem> items) {
    this.items
      ..clear()
      ..addAll(items);
    updateIndex(currentIndex);
  }

  //更新下标
  @protected
  void updateIndex(int index) => _currentIndex.setValue(index);

  //选中某一个对象
  void selectItem(int index) {
    if (index < 0 || index > items.length) index = 0;
    pageController.jumpToPage(index);
  }

  //添加下标变化监听
  void addChangeListener(OnNavigationChange onChange) {
    _currentIndex.addListener(() => onChange(currentIndex));
    _badges.addListener(() => onChange(currentIndex));
  }

  //根据下标获取角标对象
  Widget? getBadge(int index) => _badges.value[index];

  //添加角标
  void addBadge(int index, JBadgeView badge) => _badges.putValue(index, badge);

  //移除角标
  void removeBadge(int index) => _badges.removeValue(index);
}

/*
* 底部导航子项，包含页面视图
* @author wuxubaiyang
* @Time 2021/7/12 上午10:11
*/
class NavigationItem {
  //内容视图，必须继承自navigationPage
  NavigationPage page;

  //导航子项标题
  Widget? title;

  //选中状态子项标题
  Widget? activeTitle;

  //导航子项图片
  Widget? image;

  //选中状态子项图片
  Widget? activeImage;

  NavigationItem({
    required this.page,
    this.title,
    Widget? activeTitle,
    this.image,
    Widget? activeImage,
  })  : this.activeTitle = activeTitle ?? title,
        this.activeImage = activeImage ?? image;
}

/*
* 常用底部导航子项
* @author wuxubaiyang
* @Time 2021/7/12 下午2:29
*/
class NormalNavigationItem extends NavigationItem {
  NormalNavigationItem({
    required NavigationPage page,
    String title = "",
    double fontSize = 14,
    Color titleColor = Colors.black,
    String? activeTitle,
    double? activeFontSize,
    Color? activeTitleColor,
    Widget? image,
    Widget? activeImage,
  }) : super(
          page: page,
          title: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: titleColor,
            ),
          ),
          activeTitle: Text(
            activeTitle ?? title,
            style: TextStyle(
              fontSize: activeFontSize ?? fontSize,
              color: activeTitleColor ?? titleColor,
            ),
          ),
          image: image,
          activeImage: activeImage,
        );
}
