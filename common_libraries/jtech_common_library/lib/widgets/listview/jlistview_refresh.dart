import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/listview/BaseListView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  //是否展示分割线
  final bool showDivider;

  //启用下拉刷新
  final bool enablePullDown;

  //启用上拉加载
  final bool enablePullUp;

  //启用初始化加载
  final bool initialRefresh;

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
    this.initialRefresh = false,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.showDivider = false,
    this.onPullDownRefreshing,
    this.onPullUpLoading,
    this.header,
    this.footer,
  }) : super(
          controller: controller ?? JRefreshListViewController(),
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
        );

  @override
  void initState() {
    super.initState();
    //启动初始化下拉刷新
    if (initialRefresh) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        controller.refreshController.requestRefresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      onRefresh: () => _loadDataList(false),
      onLoading: () => _loadDataList(true),
      header: header?.value ?? ClassicHeader(),
      footer: footer?.value ?? ClassicFooter(),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: controller.dataLength,
        itemBuilder: (context, index) {
          var item = controller.getItem(index);
          return itemBuilder(context, item, index);
        },
        separatorBuilder: _buildDivider,
      ),
    );
  }

  //数据加载方法
  void _loadDataList(bool loadMore) async {
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
    if (!showDivider || null == dividerBuilder) return Container();
    return dividerBuilder!(context, index);
  }
}

/*
* 刷新列表组件控制器
* @author wuxubaiyang
* @Time 2021/7/7 上午11:25
*/
class JRefreshListViewController<V> extends JListViewController<V> {
  //列表刷新控制器
  @protected
  final RefreshController refreshController;

  //页码累积数量
  final int pageAddStep;

  //分页-单页数据量
  final int pageSize;

  //分页-默认初始页面
  final int initPageIndex;

  //分页-页码
  int pageIndex;

  JRefreshListViewController({
    this.initPageIndex = 1,
    this.pageSize = 15,
    this.pageAddStep = 1,
  })  : pageIndex = initPageIndex,
        refreshController = RefreshController();

  //页码增加
  void addPageIndex({int? addStep}) => pageIndex += addStep ?? pageAddStep;

  //初始化页码
  void resetPageIndex() => pageIndex = initPageIndex;

  //根据刷新状态获取请求页码
  int getRequestPageIndex(bool loadMore) =>
      loadMore ? pageIndex + pageAddStep : initPageIndex;

  //完成操作
  void requestCompleted(List<V> newData, {bool loadMore = false}) {
    if (newData.isEmpty) {
      if (!loadMore) refreshCompleted(newData);
      return refreshController.loadNoData();
    }
    loadMore ? loadCompleted(newData) : refreshCompleted(newData);
  }

  //刷新完成
  void refreshCompleted(List<V> newData) {
    refreshController.refreshCompleted(resetFooterState: true);
    setData(newData);
    resetPageIndex();
  }

  //加载完成
  void loadCompleted(List<V> newData) {
    refreshController.loadComplete();
    addData(newData);
    addPageIndex();
  }

  //失败
  void requestFail(bool loadMore) => loadMore ? loadFail() : refreshFail();

  //刷新失败
  void refreshFail() => refreshController.refreshFailed();

  //加载失败
  void loadFail() => refreshController.loadFailed();
}

//下拉刷新头部样式构建回调
typedef Widget HeaderBuilder(BuildContext context, jRefreshStatus? mode);

//上拉加载足部样式构建回调
typedef Widget FooterBuilder(BuildContext context, jLoadStatus? mode);

/*
* 下拉刷新头部样式
* @author wuxubaiyang
* @Time 2021/7/7 下午4:03
*/
class RefreshHeader {
  //最终选择的刷新头部
  final Widget value;

  //经典样式
  RefreshHeader.classic({String? releaseText})
      : value = ClassicHeader(
          releaseText: releaseText,
        );

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
  RefreshHeader.custom({
    required HeaderBuilder builder,
  }) : value = CustomHeader(
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
  LoadFooter.classic() {
    value = ClassicFooter();
  }

  //自定义样式
  LoadFooter.custom({required FooterBuilder builder}) {
    value = CustomFooter(builder: (context, model) {
      return builder(context, convertStatus(model));
    });
  }

  //将refresh库的状态转变为本地状态
  jLoadStatus? convertStatus(LoadStatus? status) {
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
