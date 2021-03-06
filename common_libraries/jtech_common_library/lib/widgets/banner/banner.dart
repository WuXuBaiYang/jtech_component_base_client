import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

//banner点击回调
typedef OnBannerItemTap = void Function(BannerItem item, int index);

//banner长点击回调
typedef OnBannerItemLongTap = void Function(BannerItem item, int index);

/*
* 轮播图组件
* @author wuxubaiyang
* @Time 2021/7/13 下午4:45
*/
class JBanner extends BaseStatefulWidget {
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

  //判断是否展示标题
  final bool showTitle;

  //子项标题背景颜色
  final Color titleBackgroundColor;

  //子项标题内间距
  final EdgeInsets titlePadding;

  //子项标题外间距
  final EdgeInsets titleMargin;

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

  JBanner({
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
  BaseState<BaseStatefulWidget> getState() => _JBannerState();
}

/*
* 轮播图组件状态
* @author jtechjh
* @Time 2021/8/13 11:11 上午
*/
class _JBannerState extends BaseState<JBanner> {
  @override
  void initState() {
    super.initState();
    //监听页面变化，实现无限滚动
    widget.pageController.addListener(() {
      if (canInfinity) {
        var page = widget.pageController.page ?? 0;
        if (page <= 0.01) {
          Future.delayed(Duration.zero).then((value) =>
              widget.pageController.jumpToPage(currentItemLength - 2));
        } else if (page >= currentItemLength - 1.01) {
          Future.delayed(Duration.zero)
              .then((value) => widget.pageController.jumpToPage(1));
        }
      }
    });
    widget.controller.indexListenable.addListener(() {
      if (isInteger(widget.pageController.page ?? 0.5)) {
        var index = widget.controller.currentIndex;
        if (canInfinity) index += 1;
        widget.pageController.animateToPage(
          index,
          curve: Curves.ease,
          duration: widget.pageChangeDuration,
        );
      }
    });
    //启动自动切换
    _startAutoChange();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor,
      elevation: widget.elevation,
      margin: widget.margin,
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius,
      ),
      child: Container(
        height: widget.height,
        padding: widget.padding,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
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
      physics: widget.canScroll ? null : NeverScrollableScrollPhysics(),
      itemCount: currentItemLength,
      controller: widget.pageController,
      itemBuilder: (context, index) => _buildBannerItem(
          context, getCurrentItem(index), getCurrentIndex(index)),
      onPageChanged: (index) =>
          widget.controller.select(getCurrentIndex(index)),
    );
  }

  //构建banner子项
  Widget _buildBannerItem(BuildContext context, BannerItem item, int index) {
    return GestureDetector(
      child: item.builder(context),
      onTap: null != widget.itemTap ? () => widget.itemTap!(item, index) : null,
      onLongPress: null != widget.itemLongTap
          ? () => widget.itemLongTap!(item, index)
          : null,
    );
  }

  //构建banner标题
  Widget _buildBannerTitle() {
    if (!widget.showTitle) return EmptyBox();
    return Align(
      alignment: widget.titleAlign.align,
      child: Container(
        width: widget.titleAlign.isVertical ? null : double.infinity,
        height: !widget.titleAlign.isVertical ? null : double.infinity,
        color: widget.titleBackgroundColor,
        padding: widget.titlePadding,
        margin: widget.titleMargin,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: widget.controller.indexListenable,
            builder: (context, currentIndex, child) =>
                widget.controller.getItem(currentIndex).title ?? EmptyBox(),
          ),
        ),
      ),
    );
  }

  //构建banner指示器
  Widget _buildBannerIndicator(BuildContext context) {
    if (!widget.showIndicator) return EmptyBox();
    return Align(
      alignment: widget.indicatorAlign.align,
      child: (widget.indicator ?? BannerDotIndicator()).build(
        context,
        widget.controller.indexListenable,
        widget.controller.itemLength,
        widget.indicatorAlign,
      ),
    );
  }

  //启动自动切换功能
  void _startAutoChange() {
    if (!widget.auto) return;
    widget.controller.startAutoChange(
      duration: widget.autoDuration,
      callback: (timer) {
        if (canInfinity) {
          widget.pageController.nextPage(
            duration: widget.pageChangeDuration,
            curve: Curves.ease,
          );
        } else {
          var index = widget.pageController.page?.round() ?? 0;
          if (++index >= widget.controller.itemLength) index = 0;
          widget.pageController.animateToPage(
            index,
            duration: widget.pageChangeDuration,
            curve: Curves.ease,
          );
        }
      },
    );
  }

  //判断当前是否可以无限滚动
  bool get canInfinity => widget.infinity && widget.controller.itemLength > 1;

  //根据当前滚动状态获取实际数据数量
  int get currentItemLength {
    var length = widget.controller.itemLength;
    if (canInfinity) length += 2;
    return length;
  }

  //根据当前滚动状态获取真实下标
  int getCurrentIndex(int index) {
    if (canInfinity) {
      index -= 1;
      if (index < 0) return widget.controller.itemLength - 1;
      if (index >= widget.controller.itemLength) return 0;
    }
    return index;
  }

  //根据当前滚动状态获取真实下标的数据对象
  BannerItem getCurrentItem(int index) {
    index = getCurrentIndex(index);
    return widget.controller.getItem(index);
  }

  //eps
  static final double eps = 1e-10;

  //判断double类型是否不存在小数
  bool isInteger(double value) => value - value.floor() < eps;

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.pageController.dispose();
    widget.controller.dispose();
  }
}
