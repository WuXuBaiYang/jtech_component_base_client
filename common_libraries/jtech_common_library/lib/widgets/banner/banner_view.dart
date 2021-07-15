import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/banner/controller.dart';
import 'package:jtech_common_library/widgets/banner/item.dart';

/*
* banner组件
* @author wuxubaiyang
* @Time 2021/7/13 下午4:45
*/
class JBannerView extends BaseStatefulWidget {
  //页面切换时间间隔
  static final Duration pageChangeDuration = const Duration(milliseconds: 500);

  //banner控制器
  final JBannerController controller;

  //页面控制器
  final PageController pageController;

  //是否可滚动
  final bool canScroll;

  //高度
  final double height;

  //外间距
  final EdgeInsets margin;

  //内间距
  final EdgeInsets padding;

  //背景色
  final Color backgroundColor;

  //整体圆角
  final BorderRadius borderRadius;

  //悬浮高度
  final double elevation;

  //是否无限滚动
  final bool infinity;

  //是否自动滚动
  final bool auto;

  //自动滚动的时间间隔
  final Duration autoDuration;

  JBannerView({
    required this.controller,
    this.canScroll = true,
    this.height = 280,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(const Radius.circular(0)),
    this.elevation = 0,
    this.infinity = true,
    this.auto = false,
    this.autoDuration = const Duration(seconds: 3),
  }) : pageController = PageController(
          initialPage: controller.currentIndex + (infinity ? 1 : 0),
        );

  @override
  void initState() {
    super.initState();
    //监听页面变化
    pageController.addListener(() {
      if (canInfinity) {
        var page = pageController.page ?? 0;
        if (page <= 0.01) {
          Future.delayed(Duration.zero).then(
              (value) => pageController.jumpToPage(currentItemLength - 2));
        } else if (page >= currentItemLength - 1.01) {
          Future.delayed(Duration.zero)
              .then((value) => pageController.jumpToPage(1));
        }
      }
    });
    controller.addChangeListener((index) {
      if (isInteger(pageController.page ?? 0.5)) {
        if (canInfinity) index += 1;
        pageController.animateToPage(
          index,
          curve: Curves.ease,
          duration: pageChangeDuration,
        );
      }
    });
    //启动自动切换
    if (auto) controller.startAutoChange(duration: autoDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Container(
        height: height,
        padding: padding,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: PageView.builder(
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: currentItemLength,
            itemBuilder: (context, index) {
              var item = getCurrentItem(index);
              return item.builder(context);
            },
            onPageChanged: (index) => controller.select(getCurrentIndex(index)),
          ),
        ),
      ),
    );
  }

  //构建banner子项
  Widget _buildBannerItem(BuildContext context, int index) {
    var item = getCurrentItem(index);
    return Stack(
      children: [
        //构建主体内容
        Positioned.fill(
          child: item.builder(context),
        ),
        //构建标题部分
        _buildBannerItemTitle(item),
      ],
    );
  }

  //构建banner子项标题部分
  Widget _buildBannerItemTitle(BannerItem item) {
    var title = item.title;
    if (null == title) return EmptyBox();
    return Align(
      alignment: title.align.align,
      child: Container(
        width: title.align.isVertical ? null : double.infinity,
        height: !title.align.isVertical ? null : double.infinity,
        color: title.backgroundColor,
        padding: title.padding,
        margin: title.margin,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          child: title.child,
        ),
      ),
    );
  }

  //判断当前是否可以无限滚动
  bool get canInfinity => infinity && controller.itemLength > 1;

  //根据当前滚动状态获取实际数据数量
  int get currentItemLength {
    var length = controller.itemLength;
    if (canInfinity) length += 2;
    return length;
  }

  //根据当前滚动状态获取真实下标
  int getCurrentIndex(int index) {
    if (canInfinity) {
      index -= 1;
      if (index < 0) return controller.itemLength - 1;
      if (index >= controller.itemLength) return 0;
    }
    return index;
  }

  //根据当前滚动状态获取真实下标的数据对象
  BannerItem getCurrentItem(int index) {
    index = getCurrentIndex(index);
    return controller.getItem(index);
  }

  //eps
  static final double eps = 1e-10;

  //判断double类型是否不存在小数
  bool isInteger(double value) => value - value.floor() < eps;

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    pageController.dispose();
    controller.dispose();
  }
}
