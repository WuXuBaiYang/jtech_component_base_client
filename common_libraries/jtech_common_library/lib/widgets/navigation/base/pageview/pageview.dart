import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 导航组件通用页面切换组件
* @author wuxubaiyang
* @Time 2021/8/14 20:29
*/
class JNavigationPageView extends BaseJNavigationState {
  //页面切换控制器
  final PageController pageController;

  //判断是否可滑动切换页面
  final bool canScroll;

  JNavigationPageView({
    this.canScroll = true,
  }) : this.pageController = PageController();

  @override
  void initState() {
    super.initState();
    //跳转到初始化页面
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      pageController.jumpToPage(widget.controller.currentIndex);
    });
    //监听页面变化
    widget.controller.indexListenable.addListener(() {
      var currentIndex = widget.controller.currentIndex;
      if (currentIndex != pageController.page?.round()) {
        pageController.jumpToPage(currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: canScroll ? null : NeverScrollableScrollPhysics(),
      children: List.generate(
        widget.controller.itemLength,
        (index) => widget.controller.getItem(index).page,
      ),
      onPageChanged: (index) => widget.controller.select(index),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    pageController.dispose();
  }
}
