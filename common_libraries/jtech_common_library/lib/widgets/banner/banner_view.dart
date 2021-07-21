import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/banner/controller.dart';
import 'package:jtech_common_library/widgets/banner/indicator/base_indicator.dart';
import 'package:jtech_common_library/widgets/banner/indicator/dot_indicator.dart';
import 'package:jtech_common_library/widgets/banner/item.dart';

//banner点击回调
typedef OnBannerItemTap = void Function(BannerItem item, int index);

//banner长点击回调
typedef OnBannerItemLongTap = void Function(BannerItem item, int index);

/*
* banner组件
* @author wuxubaiyang
* @Time 2021/7/13 下午4:45
*/
class JBannerView extends BaseStatefulWidget {
  //页面切换时间间隔
  final Duration pageChangeDuration;

  //banner控制器
  final JBannerController controller;

  //页面控制器
  final PageController pageController;

  //是否可滚动
  final bool canScroll;

  //高度
  final double height;

  //外间距
  final EdgeInsetsGeometry margin;

  //内间距
  final EdgeInsetsGeometry padding;

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

  //判断是否展示标题
  final bool showTitle;

  //子项标题背景颜色
  final Color titleBackgroundColor;

  //子项标题内间距
  final EdgeInsetsGeometry titlePadding;

  //子项标题外间距
  final EdgeInsetsGeometry titleMargin;

  //子项标题位置
  final BannerAlign titleAlign;

  //判断是否展示指示器
  final bool showIndicator;

  //指示器位置
  final BannerAlign indicatorAlign;

  //指示器构造器
  final BaseBannerIndicator? indicator;

  //点击事件
  final OnBannerItemTap? itemTap;

  //长点击事件
  final OnBannerItemLongTap? itemLongTap;

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
    this.showTitle = false,
    this.titleBackgroundColor = Colors.black38,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.titleMargin = EdgeInsets.zero,
    this.titleAlign = BannerAlign.bottom,
    this.showIndicator = true,
    this.indicatorAlign = BannerAlign.bottom,
    this.indicator,
    this.pageChangeDuration = const Duration(milliseconds: 500),
    this.itemTap,
    this.itemLongTap,
  }) : pageController = PageController(
          initialPage: controller.currentIndex + (infinity ? 1 : 0),
        );

  @override
  void initState() {
    super.initState();
    //监听页面变化，实现无限滚动
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
    controller.indexListenable.addListener(() {
      if (isInteger(pageController.page ?? 0.5)) {
        var index = controller.currentIndex;
        if (canInfinity) index += 1;
        pageController.animateToPage(
          index,
          curve: Curves.ease,
          duration: pageChangeDuration,
        );
      }
    });
    //启动自动切换
    _startAutoChange();
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
          child: Stack(
            children: [
              _buildBannerContent(),
              _buildBannerTitle(),
              _buildBannerIndicator(context),
            ],
          ),
        ),
      ),
    );
  }

  //构建banner内容
  Widget _buildBannerContent() {
    return PageView.builder(
      physics: canScroll ? null : NeverScrollableScrollPhysics(),
      itemCount: currentItemLength,
      controller: pageController,
      itemBuilder: (context, index) =>
          _buildBannerItem(context, getCurrentItem(index), getCurrentIndex(index)),
      onPageChanged: (index) => controller.select(getCurrentIndex(index)),
    );
  }

  //构建banner子项
  Widget _buildBannerItem(BuildContext context, BannerItem item, int index) {
    return GestureDetector(
      child: item.builder(context),
      onTap: null != itemTap
          ? () {
              Feedback.forTap(context);
              itemTap!(item, index);
            }
          : null,
      onLongPress: null != itemLongTap
          ? () {
              Feedback.forLongPress(context);
              itemLongTap!(item, index);
            }
          : null,
    );
  }

  //构建banner标题
  Widget _buildBannerTitle() {
    if (!showTitle) return EmptyBox();
    return Align(
      alignment: titleAlign.align,
      child: Container(
        width: titleAlign.isVertical ? null : double.infinity,
        height: !titleAlign.isVertical ? null : double.infinity,
        color: titleBackgroundColor,
        padding: titlePadding,
        margin: titleMargin,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.indexListenable,
            builder: (context, currentIndex, child) =>
                controller.getItem(currentIndex).title ?? EmptyBox(),
          ),
        ),
      ),
    );
  }

  //构建banner指示器
  Widget _buildBannerIndicator(BuildContext context) {
    if (!showIndicator) return EmptyBox();
    return Align(
      alignment: indicatorAlign.align,
      child: (indicator ?? BannerDotIndicator()).build(
        context,
        controller.indexListenable,
        controller.itemLength,
        indicatorAlign,
      ),
    );
  }

  //启动自动切换功能
  void _startAutoChange() {
    if (!auto) return;
    controller.startAutoChange(
      duration: autoDuration,
      callback: (timer) {
        if (canInfinity) {
          pageController.nextPage(
            duration: pageChangeDuration,
            curve: Curves.ease,
          );
        } else {
          var index = pageController.page?.round() ?? 0;
          if (++index >= controller.itemLength) index = 0;
          pageController.animateToPage(
            index,
            duration: pageChangeDuration,
            curve: Curves.ease,
          );
        }
      },
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
