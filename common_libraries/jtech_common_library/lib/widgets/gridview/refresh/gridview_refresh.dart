import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/base/refresh/config.dart';
import 'package:jtech_common_library/widgets/gridview/base/base_gridview.dart';
import 'package:jtech_common_library/widgets/gridview/base/staggered.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/config.dart';
import 'package:jtech_common_library/widgets/gridview/refresh/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 刷新表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JRefreshGridView<V>
    extends BaseGridView<JRefreshGridViewController<V>, V> {
  //刷新组件配置文件
  final RefreshGridConfig<V> config;

  JRefreshGridView({
    required GridItemBuilder<V> itemBuilder,
    required OnRefreshLoad<V> onRefreshLoad,
    required int crossAxisCount,
    JRefreshGridViewController<V>? controller,
    RefreshGridConfig<V>? config,
    bool? enablePullDown,
    bool? enablePullUp,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    OnGridItemTap<V>? itemTap,
    OnGridItemLongTap<V>? itemLongTap,
    StaggeredTileBuilder? staggeredTileBuilder,
    JStaggeredTile? staggeredTile,
  })  : this.config = (config ?? RefreshGridConfig()).copyWith(
          onRefreshLoad: onRefreshLoad,
          crossAxisCount: crossAxisCount,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
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
          enablePullDown: config.enablePullDown,
          enablePullUp: config.enablePullUp,
          onRefresh: () => _loadDataList(false),
          onLoading: () => _loadDataList(true),
          header: config.header?.value ?? ClassicHeader(),
          footer: config.footer?.value ?? ClassicFooter(),
          child: StaggeredGridView.countBuilder(
            itemBuilder: (context, index) =>
                buildGridItem(context, dataList[index], index),
            staggeredTileBuilder: (int index) =>
                buildGridStaggered(dataList[index], index),
            mainAxisSpacing: config.mainAxisSpacing,
            crossAxisSpacing: config.crossAxisSpacing,
            crossAxisCount: config.crossAxisCount,
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
        ? config.onPullUpLoading?.call()
        : config.onPullDownRefreshing?.call();
    try {
      List<V>? result = await config.onRefreshLoad
          ?.call(controller.getRequestPageIndex(loadMore), controller.pageSize);
      //执行加载完成操作
      controller.requestCompleted(result ?? [], loadMore: loadMore);
    } catch (e) {
      controller.requestFail(loadMore);
    }
  }
}
