import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/base/ValueChangeNotifier.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';
import 'package:jtech_common_library/widgets/bottom_navigation/navgiation_page.dart';

/*
* 底部导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:13
*/
class JBottomNavigation<T extends NavigationItem> extends BaseStatefulWidget {
  //底部导航控制器
  final JBottomNavigationController controller;

  //初始下标
  final int initIndex;

  //判断是否可滑动切换页面
  final bool canSlide;

  //导航子项集合
  final List<T> items;

  //导航条颜色
  final Color navigationColor;

  //导航条内间距
  final EdgeInsets navigationPadding;

  //导航条悬浮高度
  final double elevation;

  //角标显示位置
  final Alignment badgeAlign;

  JBottomNavigation({
    JBottomNavigationController? controller,
    required this.items,
    this.initIndex = 0,
    this.canSlide = false,
    this.navigationColor = Colors.white,
    this.navigationPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.elevation = 8,
    this.badgeAlign = Alignment.topRight,
  }) : this.controller = controller ?? JBottomNavigationController();

  @override
  void initState() {
    super.initState();
    //刷新初始下标
    controller.updateIndex(initIndex);
    //监听角标变化
    controller.addBadgeListener(() => refreshUI());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            physics: canSlide ? null : NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (index) =>
                refreshUI(() => controller.updateIndex(index)),
            children: List.generate(items.length, (index) => items[index].page),
          ),
        ),
        _buildBottomNavigation(),
      ],
    );
  }

  //构建底部导航
  _buildBottomNavigation() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      color: navigationColor,
      elevation: elevation,
      child: Container(
        padding: navigationPadding,
        child: Row(
          children: List.generate(items.length, (index) {
            var item = items[index];
            bool selected = index == controller.currentIndex;
            return Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: InkWell(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (selected ? item.activeTitle : item.title) ??
                              EmptyBox(),
                          (selected ? item.activeImage : item.image) ??
                              EmptyBox(),
                        ],
                      ),
                      onTap: () {
                        refreshUI(() => controller.updateIndex(index));
                        controller.pageController.jumpToPage(index);
                      },
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

//底部导航变化监听
typedef OnBottomNavigationChange = void Function(int index);

/*
* 底部导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 上午9:53
*/
class JBottomNavigationController<T extends JBadgeView> {
  //管理维护pageView控制器
  @protected
  final PageController pageController;

  //记录当前选中下标
  ValueChangeNotifier<int> _currentIndex;

  //维护角标对象
  final MapValueChangeNotifier<int, T> _badges;

  JBottomNavigationController()
      : _currentIndex = ValueChangeNotifier(0),
        _badges = MapValueChangeNotifier({}),
        pageController = PageController();

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //更新下标
  @protected
  void updateIndex(int newIndex) => _currentIndex.setValue(newIndex);

  //添加下标变化监听
  void addChangeListener(OnBottomNavigationChange onChange) =>
      _currentIndex.addListener(() => onChange(currentIndex));

  //监听角标变化
  @protected
  void addBadgeListener(VoidCallback listener) => _badges.addListener(listener);

  //根据下标获取角标对象
  T? getBadge(int index) => _badges.value[index];

  //添加角标
  void addBadge(int index, T badge) => _badges.putValue(index, badge);
}

/*
* 底部导航子项，包含页面视图
* @author wuxubaiyang
* @Time 2021/7/12 上午10:11
*/
class NavigationItem<T extends NavigationPage> {
  //内容视图，必须继承自navigationPage
  T page;

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
    this.activeTitle,
    this.image,
    this.activeImage,
  });
}
