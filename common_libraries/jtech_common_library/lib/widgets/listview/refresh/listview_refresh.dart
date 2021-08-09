import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/base/refresh/config.dart';
import 'package:jtech_common_library/widgets/listview/base/base_listView.dart';
import 'package:jtech_common_library/widgets/listview/refresh/config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'controller.dart';

/*
* 带有下拉刷新的列表组件
* @author wuxubaiyang
* @Time 2021/7/7 上午11:24
*/
class JRefreshListView<V>
    extends BaseListView<JRefreshListViewController<V>, V> {
  //刷新列表组件配置
  final RefreshListConfig<V> config;

  JRefreshListView({
    required ListItemBuilder<V> itemBuilder,
    required OnRefreshLoad<V> onRefreshLoad,
    JRefreshListViewController<V>? controller,
    ListDividerBuilder? dividerBuilder,
    bool? enablePullDown,
    bool? enablePullUp,
    OnListItemTap<V>? itemTap,
    OnListItemLongTap<V>? itemLongTap,
    RefreshListConfig<V>? config,
  })  : this.config = (config ?? RefreshListConfig()).copyWith(
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          onRefreshLoad: onRefreshLoad,
        ),
        super(
          controller: controller ?? JRefreshListViewController(),
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
          itemTap: itemTap,
          itemLongTap: itemLongTap,
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
