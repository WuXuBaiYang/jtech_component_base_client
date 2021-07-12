import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/badge/badge_view.dart';
import 'package:jtech_common_library/widgets/base/ValueChangeNotifier.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';
import 'package:jtech_common_library/widgets/tab_layout/tab_page.dart';

/*
* 顶部分页导航
* @author wuxubaiyang
* @Time 2021/7/12 上午9:26
*/
class JTabLayout extends BaseStatefulWidget<_JTabLayoutState> {
  //控制器
  final JTabLayoutController controller;

  //初始下标
  final int initIndex;

  //判断是否可滑动切换页面
  final bool canScroll;

  //持有state对象
  final _JTabLayoutState tabLayoutState;

  //tab导航栏颜色
  final Color tabBarColor;

  //tab导航栏高度
  final double tabBarHeight;

  //tab导航栏悬浮高度
  final double elevation;

  //导航栏tab是否可滚动
  final bool isFixed;

  //指示器配置对象
  final IndicatorConfig indicatorConfig;

  //角标对齐位置
  final Alignment badgeAlign;

  JTabLayout({
    JTabLayoutController? controller,
    required List<TabItem> items,
    int initIndex = 0,
    this.canScroll = true,
    this.tabBarColor = Colors.transparent,
    this.elevation = 0,
    this.isFixed = true,
    this.tabBarHeight = 55,
    this.badgeAlign = Alignment.topRight,
    IndicatorConfig? indicatorConfig,
  })  : tabLayoutState = _JTabLayoutState(),
        this.indicatorConfig = indicatorConfig ?? IndicatorConfig(),
        this.controller = controller ?? JTabLayoutController(),
        this.initIndex =
            (initIndex < 0 || initIndex > items.length) ? 0 : initIndex {
    this.controller.init(items, tabLayoutState);
  }

  @override
  void initState() {
    super.initState();
    //刷新初始下标
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.tabController?.animateTo(initIndex);
    });
    //监听页码变化
    controller.addChangeListener((index) => refreshUI());
  }

  @override
  State<StatefulWidget> createState() => tabLayoutState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(),
          color: tabBarColor,
          elevation: elevation,
          child: TabBar(
            controller: controller.tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.black,
            isScrollable: !isFixed,
            indicator: indicatorConfig.decoration,
            indicatorColor: indicatorConfig.color,
            indicatorPadding: indicatorConfig.padding,
            indicatorWeight: indicatorConfig.weight,
            indicatorSize: indicatorConfig.indicatorSize,
            onTap: (index) => controller.updateIndex(index),
            tabs: List.generate(controller.items.length, (index) {
              var item = controller.items[index];
              bool selected = index == controller.currentIndex;
              return Container(
                height: tabBarHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
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
        Expanded(
          child: TabBarView(
            physics: canScroll ? null : NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: List.generate(controller.items.length,
                (index) => controller.items[index].page),
          ),
        )
      ],
    );
  }
}

/*
* tab——state持有
* @author wuxubaiyang
* @Time 2021/7/12 下午3:25
*/
class _JTabLayoutState extends BaseStatefulWidgetState
    with SingleTickerProviderStateMixin {}

//顶部tab导航变化监听
typedef OnTabChange = void Function(int index);

/*
* 顶部tab导航控制器
* @author wuxubaiyang
* @Time 2021/7/12 下午2:53
*/
class JTabLayoutController {
  //tab导航控制器
  @protected
  TabController? tabController;

  //tab导航子项集合
  final List<TabItem> items = [];

  //下标对象持有
  final ValueChangeNotifier<int> _currentIndex;

  //维护角标对象
  final MapValueChangeNotifier<int, Widget> _badges;

  JTabLayoutController()
      : this._currentIndex = ValueChangeNotifier(0),
        _badges = MapValueChangeNotifier({});

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //初始化控制器以及内部数据
  @protected
  void init(List<TabItem> items, _JTabLayoutState state) {
    tabController = TabController(length: items.length, vsync: state);
    this.items
      ..clear()
      ..addAll(items);
    //监听数据变化
    tabController!.addListener(() {
      if (!tabController!.indexIsChanging &&
          tabController!.index != currentIndex &&
          //因为快速滑动的时候，页面会滑超过，所以需要加一个限制
          (tabController!.index - currentIndex).abs() <= 1) {
        updateIndex(tabController!.index);
      }
    });
  }

  //更新下标
  @protected
  void updateIndex(int index) => _currentIndex.setValue(index);

  //选中子项
  void selectItem(int index) {
    if (index < 0 || index > items.length) index = 0;
    tabController?.animateTo(index);
    updateIndex(index);
  }

  //添加下标变化监听
  void addChangeListener(OnTabChange onChange) {
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
* 顶部tab导航子项对象
* @author wuxubaiyang
* @Time 2021/7/12 下午2:55
*/
class TabItem {
  //内容视图，必须继承自tabPage
  TabPage page;

  //导航子项标题
  Widget? title;

  //选中状态子项标题
  Widget? activeTitle;

  //导航子项图片
  Widget? image;

  //选中状态子项图片
  Widget? activeImage;

  TabItem({
    required this.page,
    this.title,
    Widget? activeTitle,
    this.image,
    Widget? activeImage,
  })  : this.activeTitle = activeTitle ?? title,
        this.activeImage = activeImage ?? image;
}

/*
* 常用顶部导航子项对象
* @author wuxubaiyang
* @Time 2021/7/12 下午2:57
*/
class NormalTabItem extends TabItem {
  NormalTabItem({
    required TabPage page,
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

/*
* 指示器配置
* @author wuxubaiyang
* @Time 2021/7/12 下午4:50
*/
class IndicatorConfig {
  //指示器颜色
  Color? color;

  //指示器比重
  double weight;

  //指示器内间距
  EdgeInsets padding;

  //指示器容器设置
  Decoration? decoration;

  //指示器大小(true:与tab宽度相当，false，与文本宽度相当)
  bool sizeByTab;

  IndicatorConfig({
    this.color,
    this.weight = 2.0,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.sizeByTab = true,
  });

  //获取指示器显示大小
  @protected
  TabBarIndicatorSize get indicatorSize =>
      sizeByTab ? TabBarIndicatorSize.tab : TabBarIndicatorSize.label;
}
