import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/base/refresh/config.dart';
import 'package:jtech_common_library/widgets/gridview/base/base_gridview.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 刷新表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JRefreshGridView<V>
    extends BaseGridView<JRefreshGridViewController<V>, V> {
  //副方向上的最大元素数量
  final int crossAxisCount;

  //主方向元素间距
  final double mainAxisSpacing;

  //副方向元素间距
  final double crossAxisSpacing;

  //刷新组件配置文件
  final RefreshConfig<V> refreshConfig;

  JRefreshGridView({
    required GridItemBuilder<V> itemBuilder,
    required OnRefreshLoad<V> onRefreshLoad,
    required this.crossAxisCount,
    JRefreshGridViewController<V>? controller,
    RefreshConfig<V>? refreshConfig,
    bool? enablePullDown,
    bool? enablePullUp,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    StaggeredTileBuilder? staggeredTileBuilder,
    JStaggeredTile? staggeredTile,
  })  : this.refreshConfig = (refreshConfig ?? RefreshConfig()).copyWith(
          onRefreshLoad: onRefreshLoad,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
        ),
        super(
          controller: controller ?? JRefreshGridViewController(),
          itemBuilder: itemBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
          staggeredTile: staggeredTile,
          staggeredTileBuilder: staggeredTileBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
      valueListenable: controller.dataListenable,
      builder: (context, dataList, child) {
        return SmartRefresher(
          controller: controller.refreshController,
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
    loadMore
        ? refreshConfig.onPullUpLoading?.call()
        : refreshConfig.onPullDownRefreshing?.call();
    try {
      List<V>? result = await refreshConfig.onRefreshLoad
          ?.call(controller.getRequestPageIndex(loadMore), controller.pageSize);
      //执行加载完成操作
      controller.requestCompleted(result ?? [], loadMore: loadMore);
    } catch (e) {
      controller.requestFail(loadMore);
    }
  }
}
