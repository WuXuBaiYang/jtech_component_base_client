import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/base/config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//下拉刷新头部样式构建回调
typedef Widget HeaderBuilder(BuildContext context, jRefreshStatus? mode);

//上拉加载足部样式构建回调
typedef Widget FooterBuilder(BuildContext context, jLoadStatus? mode);

//数据加载异步回调
typedef OnRefreshLoad<V> = Future<List<V>> Function(
    int pageIndex, int pageSize);

/*
* 刷新组件配置通用部分
* @author jtechjh
* @Time 2021/8/9 3:18 下午
*/
abstract class RefreshConfig<V> extends BaseConfig{
  //启用下拉刷新
  bool enablePullDown;

  //启用上拉加载
  bool enablePullUp;

  //下拉刷新回调
  Function? onPullDownRefreshing;

  //上拉加载回调
  Function? onPullUpLoading;

  //数据加载回调
  OnRefreshLoad<V>? onRefreshLoad;

  //头部样式类型
  RefreshHeader? header;

  //足部样式类型
  LoadFooter? footer;

  RefreshConfig({
    required this.enablePullDown,
    required this.enablePullUp,
    required this.onPullDownRefreshing,
    required this.onPullUpLoading,
    required this.onRefreshLoad,
    required this.header,
    required this.footer,
  });
}

/*
* 下拉刷新头部样式
* @author wuxubaiyang
* @Time 2021/7/7 下午4:03
*/
class RefreshHeader {
  //最终选择的刷新头部
  final Widget value;

  //经典样式
  RefreshHeader.classic() : value = ClassicHeader();

  //水滴样式
  RefreshHeader.waterDrop() : value = WaterDropHeader();

  //material风格的经典样式
  RefreshHeader.materialClassic() : value = MaterialClassicHeader();

  //material风格的水滴样式
  RefreshHeader.waterDropMaterial() : value = WaterDropMaterialHeader();

  //bezier样式
  RefreshHeader.bezier() : value = BezierHeader();

  //bezierCircle样式
  RefreshHeader.bezierCircle() : value = BezierCircleHeader();

  //自定义样式
  RefreshHeader.custom({required HeaderBuilder builder})
      : value = CustomHeader(
          builder: (context, model) => builder(context, _convertStatus(model)),
        );

  //将refresh库的状态转变为本地状态
  static jRefreshStatus? _convertStatus(RefreshStatus? status) {
    switch (status) {
      case RefreshStatus.idle:
        return jRefreshStatus.idle;
      case RefreshStatus.canRefresh:
        return jRefreshStatus.canRefresh;
      case RefreshStatus.refreshing:
        return jRefreshStatus.refreshing;
      case RefreshStatus.completed:
        return jRefreshStatus.completed;
      case RefreshStatus.failed:
        return jRefreshStatus.failed;
      case RefreshStatus.canTwoLevel:
      case RefreshStatus.twoLevelOpening:
      case RefreshStatus.twoLeveling:
      case RefreshStatus.twoLevelClosing:
        break;
      default:
        return null;
    }
  }
}

/*
* 自定义的下拉刷新状态
* @author wuxubaiyang
* @Time 2021/7/7 下午4:33
*/
enum jRefreshStatus {
  idle,
  canRefresh,
  refreshing,
  completed,
  failed,
}

/*
* 上拉加载足部样式
* @author wuxubaiyang
* @Time 2021/7/7 下午4:03
*/
class LoadFooter {
  //最终选择的刷新头部
  Widget? value;

  //经典样式
  LoadFooter.classic() : value = ClassicFooter();

  //自定义样式
  LoadFooter.custom({required FooterBuilder builder})
      : value = CustomFooter(builder: (context, model) {
          return builder(context, _convertStatus(model));
        });

  //将refresh库的状态转变为本地状态
  static jLoadStatus? _convertStatus(LoadStatus? status) {
    switch (status) {
      case LoadStatus.idle:
        return jLoadStatus.idle;
      case LoadStatus.canLoading:
        return jLoadStatus.canLoading;
      case LoadStatus.loading:
        return jLoadStatus.loading;
      case LoadStatus.noMore:
        return jLoadStatus.noMore;
      case LoadStatus.failed:
        return jLoadStatus.failed;
      default:
        return null;
    }
  }
}

/*
* 自定义的上拉加载状态
* @author wuxubaiyang
* @Time 2021/7/7 下午4:33
*/
enum jLoadStatus {
  idle,
  canLoading,
  loading,
  noMore,
  failed,
}
