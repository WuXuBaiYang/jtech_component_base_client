import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/base/change_notifier.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 刷新控制器通用方法
* @author wuxubaiyang
* @Time 2021/7/20 下午5:00
*/
class JRefreshListViewController<V> extends JListViewController<V> {
  //分页-默认初始页面
  int _initPageIndex;

  //页码累积数量
  int _pageAddStep;

  //分页-单页数据量
  int _pageSize;

  //分页-页码
  int _pageIndex;

  //刷新状态
  ValueChangeNotifier<RefreshState> _refreshState;

  //刷新控制器
  RefreshController _refreshController;

  //获取刷新控制器
  RefreshController get refreshController => _refreshController;

  //获取单页数据量
  int get pageSize => _pageSize;

  //获取当前页码
  int get pageIndex => _pageIndex;

  //获取初始化页码下标
  int get initPageIndex => _initPageIndex;

  //获取当前刷新状态
  RefreshState get refreshState => _refreshState.value;

  //创建方法，用于初始化刷新控制器参数
  JRefreshListViewController({
    int initPageIndex = 1,
    int pageIndex = 1,
    int pageAddStep = 1,
    int pageSize = 15,
    bool initialRefresh = true,
  })  : this._refreshController =
            RefreshController(initialRefresh: initialRefresh),
        this._refreshState = ValueChangeNotifier(RefreshState.none),
        this._initPageIndex = initPageIndex,
        this._pageIndex = pageIndex,
        this._pageSize = pageSize,
        this._pageAddStep = pageAddStep {
    //监听刷新状态变化
    _refreshState.addListener(() {
      switch (refreshState) {
        case RefreshState.refreshCompleted:
          return refreshController.refreshCompleted(resetFooterState: true);
        case RefreshState.refreshFailed:
          return refreshController.refreshFailed();
        case RefreshState.loadComplete:
          return refreshController.loadComplete();
        case RefreshState.loadFailed:
          return refreshController.loadFailed();
        case RefreshState.loadNoData:
          return refreshController.loadNoData();
        case RefreshState.none:
          return;
      }
    });
  }

  //页码增加
  void addPageIndex({int? addStep}) => _pageIndex += addStep ?? _pageAddStep;

  //初始化页码
  void resetPageIndex() => _pageIndex = _initPageIndex;

  //根据刷新状态获取请求页码
  int getRequestPageIndex(bool loadMore) =>
      loadMore ? _pageIndex + _pageAddStep : _initPageIndex;

  //完成操作
  void requestCompleted(List<V> newData, {bool loadMore = false}) {
    if (newData.isEmpty || newData.length < _pageSize) {
      if (!loadMore) refreshCompleted(newData);
      return loadNoMoreData();
    }
    loadMore ? loadCompleted(newData) : refreshCompleted(newData);
  }

  //刷新完成
  void refreshCompleted(List<V> newData) {
    _refreshState.setValue(RefreshState.refreshCompleted);
    setData(newData);
    resetPageIndex();
  }

  //加载完成
  void loadCompleted(List<V> newData) {
    _refreshState.setValue(RefreshState.loadComplete);
    addData(newData);
    addPageIndex();
  }

  //加载无更多数据状态
  void loadNoMoreData() => _refreshState.setValue(RefreshState.loadNoData);

  //失败
  void requestFail(bool loadMore) => loadMore ? loadFail() : refreshFail();

  //刷新失败
  void refreshFail() => _refreshState.setValue(RefreshState.refreshFailed);

  //加载失败
  void loadFail() => _refreshState.setValue(RefreshState.loadFailed);

  //重置刷新状态
  void resetRefreshState() => _refreshState.setValue(RefreshState.none);

  @override
  void addListener(VoidCallback listener) {
    _refreshState.addListener(listener);
    super.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    _refreshController.dispose();
  }
}

/*
* 刷新状态枚举
* @author wuxubaiyang
* @Time 2021/7/15 上午9:58
*/
enum RefreshState {
  refreshCompleted,
  refreshFailed,
  loadComplete,
  loadFailed,
  loadNoData,
  none,
}
