import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 带有下拉刷新的列表组件
* @author wuxubaiyang
* @Time 2021/7/7 上午11:24
*/
class JListViewRefreshState<V>
    extends BaseJListViewState<JRefreshListViewController<V>, V> {
  //刷新列表组件配置
  final RefreshConfig<V> refreshConfig;

  JListViewRefreshState({
    required this.refreshConfig,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: widget.controller.dataListenable,
      builder: (context, dataList, child) {
        return SmartRefresher(
          controller: widget.controller.refreshController,
          enablePullDown: refreshConfig.enablePullDown,
          enablePullUp: refreshConfig.enablePullUp,
          onRefresh: () => _loadDataList(false),
          onLoading: () => _loadDataList(true),
          header: refreshConfig.header?.value ?? ClassicHeader(),
          footer: refreshConfig.footer?.value ?? ClassicFooter(),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: dataList.length,
            itemBuilder: (context, index) =>
                buildListItem(context, dataList[index], index),
            separatorBuilder: buildDivider,
          ),
        );
      },
    );
  }

  //数据加载方法
  void _loadDataList(bool loadMore) async {
    widget.controller.resetRefreshState();
    loadMore
        ? refreshConfig.onPullUpLoading?.call()
        : refreshConfig.onPullDownRefreshing?.call();
    try {
      List<V>? result = await refreshConfig.onRefreshLoad?.call(
          widget.controller.getRequestPageIndex(loadMore),
          widget.controller.pageSize);
      //执行加载完成操作
      widget.controller.requestCompleted(result ?? [], loadMore: loadMore);
    } catch (e) {
      widget.controller.requestFail(loadMore);
    }
  }
}
