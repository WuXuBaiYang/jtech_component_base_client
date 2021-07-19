import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/listview/base/base_listView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config.dart';
import 'controller.dart';

//数据加载异步回调
typedef OnRefreshListViewLoad<V> = Future<List<V>> Function(
    int pageIndex, int pageSize);

/*
* 带有下拉刷新的列表组件
* @author wuxubaiyang
* @Time 2021/7/7 上午11:24
*/
class JRefreshListView<V>
    extends BaseListView<JRefreshListViewController<V>, V> {
  //刷新控制器
  final RefreshController refreshController;

  //是否展示分割线
  final bool showDivider;

  //启用下拉刷新
  final bool enablePullDown;

  //启用上拉加载
  final bool enablePullUp;

  //下拉刷新回调
  final Function? onPullDownRefreshing;

  //上拉加载回调
  final Function? onPullUpLoading;

  //列表组件数据加载回调
  final OnRefreshListViewLoad<V> onRefreshListViewLoad;

  //头部样式类型
  final RefreshHeader? header;

  //足部样式类型
  final LoadFooter? footer;

  JRefreshListView({
    required ListItemBuilder<V> itemBuilder,
    required this.onRefreshListViewLoad,
    JRefreshListViewController<V>? controller,
    ListDividerBuilder? dividerBuilder,
    bool initialRefresh = false,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.showDivider = false,
    this.onPullDownRefreshing,
    this.onPullUpLoading,
    this.header,
    this.footer,
    ListItemTap<V>? itemTap,
    ListItemLongTap<V>? itemLongTap,
  })  : refreshController = RefreshController(initialRefresh: initialRefresh),
        super(
          controller: controller ?? JRefreshListViewController(),
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
        );

  @override
  void initState() {
    super.initState();
    //监听刷新状态变化
    controller.addRefreshStateChange((state) {
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
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: dataList.length,
            itemBuilder: (context, index) =>
                buildListItem(context, dataList[index], index),
            separatorBuilder: _buildDivider,
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
      List<V> result = await onRefreshListViewLoad(
          controller.getRequestPageIndex(loadMore), controller.pageSize);
      //执行加载完成操作
      controller.requestCompleted(result, loadMore: loadMore);
    } catch (e) {
      controller.requestFail(loadMore);
    }
  }

  //构建分割线
  Widget _buildDivider(BuildContext context, int index) {
    if (!showDivider || null == dividerBuilder) return EmptyBox();
    return dividerBuilder!(context, index);
  }
}
