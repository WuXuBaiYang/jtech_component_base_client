import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/base/refresh/config.dart';
import 'package:jtech_common_library/base/refresh/controller.dart';
import 'package:jtech_common_library/widgets/gridview/base/base_gridview.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//数据加载异步回调
typedef OnRefreshGridViewLoad<V> = Future<List<V>> Function(
    int pageIndex, int pageSize);

/*
* 刷新表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JRefreshGridView<V>
    extends BaseGridView<JRefreshGridViewController<V>, V> {
  //刷新控制器
  final RefreshController refreshController;

  //启用下拉刷新
  final bool enablePullDown;

  //启用上拉加载
  final bool enablePullUp;

  //下拉刷新回调
  final Function? onPullDownRefreshing;

  //上拉加载回调
  final Function? onPullUpLoading;

  //列表组件数据加载回调
  final OnRefreshGridViewLoad<V> onRefreshGridViewLoad;

  //头部样式类型
  final RefreshHeader? header;

  //足部样式类型
  final LoadFooter? footer;

  //副方向上的最大元素数量
  final int crossAxisCount;

  //主方向元素间距
  final double mainAxisSpacing;

  //副方向元素间距
  final double crossAxisSpacing;

  JRefreshGridView({
    required GridItemBuilder<V> itemBuilder,
    required this.onRefreshGridViewLoad,
    required this.crossAxisCount,
    JRefreshGridViewController<V>? controller,
    bool initialRefresh = false,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.onPullDownRefreshing,
    this.onPullUpLoading,
    this.header,
    this.footer,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    StaggeredTileBuilder? staggeredTileBuilder,
    JStaggeredTile? staggeredTile,
  })  : refreshController = RefreshController(initialRefresh: initialRefresh),
        super(
          controller: controller ?? JRefreshGridViewController(),
          itemBuilder: itemBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
          staggeredTile: staggeredTile,
          staggeredTileBuilder: staggeredTileBuilder,
        );

  @override
  void initState() {
    super.initState();
    //监听刷新状态变化
    controller.refreshListenable.addListener(() {
      var state = controller.refreshState;
      switch (state) {
        case RefreshState.RefreshCompleted:
          return refreshController.refreshCompleted(resetFooterState: true);
        case RefreshState.RefreshFailed:
          return refreshController.refreshFailed();
        case RefreshState.LoadComplete:
          return refreshController.loadComplete();
        case RefreshState.LoadFailed:
          return refreshController.loadFailed();
        case RefreshState.LoadNoData:
          return refreshController.loadNoData();
        case RefreshState.None:
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: controller.dataListenable,
      builder: (context, dataList, child) {
        return SmartRefresher(
          controller: refreshController,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          onRefresh: () => _loadDataList(false),
          onLoading: () => _loadDataList(true),
          header: header?.value ?? ClassicHeader(),
          footer: footer?.value ?? ClassicFooter(),
          child: StaggeredGridView.countBuilder(
            itemBuilder: (context, index) =>
                buildGridItem(context, dataList[index], index),
            staggeredTileBuilder: (int index) =>
                buildGridStaggered(dataList[index], index),
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            crossAxisCount: crossAxisCount,
            itemCount: dataList.length,
            shrinkWrap: true,
          ),
        );
      },
    );
  }

  //数据加载方法
  void _loadDataList(bool loadMore) async {
    controller.resetRefreshState();
    loadMore ? onPullUpLoading?.call() : onPullDownRefreshing?.call();
    try {
      List<V> result = await onRefreshGridViewLoad(
          controller.getRequestPageIndex(loadMore), controller.pageSize);
      //执行加载完成操作
      controller.requestCompleted(result, loadMore: loadMore);
    } catch (e) {
      controller.requestFail(loadMore);
    }
  }
}
