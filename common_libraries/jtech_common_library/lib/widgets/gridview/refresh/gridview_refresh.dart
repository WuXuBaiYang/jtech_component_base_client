import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 刷新表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JGridViewRefreshState<V>
    extends BaseJGridViewState<JRefreshGridViewController<V>, V> {
  //刷新组件配置文件
  final RefreshConfig<V> refreshConfig;

  JGridViewRefreshState({
    required this.refreshConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.config.margin,
      child: ValueListenableBuilder<List<V>>(
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
            child: StaggeredGridView.countBuilder(
              itemBuilder: (context, index) =>
                  buildGridItem(context, dataList[index], index),
              staggeredTileBuilder: (int index) =>
                  buildGridStaggered(dataList[index], index),
              mainAxisSpacing: widget.config.mainAxisSpacing,
              crossAxisSpacing: widget.config.crossAxisSpacing,
              crossAxisCount: widget.crossAxisCount,
              itemCount: dataList.length,
              shrinkWrap: true,
            ),
          );
        },
      ),
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
