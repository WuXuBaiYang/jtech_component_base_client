import 'package:flutter/foundation.dart';

import '../value_change_notifier.dart';

/*
* 刷新控制器通用方法
* @author wuxubaiyang
* @Time 2021/7/20 下午5:00
*/
mixin JRefreshControllerMixin<V> {
  //分页-默认初始页面
  late int _initPageIndex;

  //页码累积数量
  late int _pageAddStep;

  //分页-单页数据量
  late int _pageSize;

  //分页-页码
  late int _pageIndex;

  //刷新状态
  late ValueChangeNotifier<RefreshState> _refreshState;

  //创建方法，用于初始化刷新控制器参数
  void create({
    int? initPageIndex,
    int? pageAddStep,
    int? pageSize,
  }) {
    this._initPageIndex = initPageIndex ?? 1;
    this._pageAddStep = pageAddStep ?? 1;
    this._pageSize = pageSize ?? 15;
    this._pageIndex = this._initPageIndex;
    this._refreshState = ValueChangeNotifier(RefreshState.None);
  }

  //获取当前页码
  int get pageIndex => _pageIndex;

  //获取单页数据量
  int get pageSize => _pageSize;

  //获取当前刷新状态
  RefreshState get refreshState => _refreshState.value;

  //设置数据
  void setRefreshData(List<V> newData);

  //添加数据
  void addRefreshData(List<V> newData);

  //获取状态变化监听
  ValueListenable<RefreshState> get refreshListenable => _refreshState;

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
    _refreshState.setValue(RefreshState.RefreshCompleted);
    setRefreshData(newData);
    resetPageIndex();
  }

  //加载完成
  void loadCompleted(List<V> newData) {
    _refreshState.setValue(RefreshState.LoadComplete);
    addRefreshData(newData);
    addPageIndex();
  }

  //加载无更多数据状态
  void loadNoMoreData() => _refreshState.setValue(RefreshState.LoadNoData);

  //失败
  void requestFail(bool loadMore) => loadMore ? loadFail() : refreshFail();

  //刷新失败
  void refreshFail() => _refreshState.setValue(RefreshState.RefreshFailed);

  //加载失败
  void loadFail() => _refreshState.setValue(RefreshState.LoadFailed);

  //重置刷新状态
  void resetRefreshState() => _refreshState.setValue(RefreshState.None);
}

/*
* 刷新状态枚举
* @author wuxubaiyang
* @Time 2021/7/15 上午9:58
*/
enum RefreshState {
  RefreshCompleted,
  RefreshFailed,
  LoadComplete,
  LoadFailed,
  LoadNoData,
  None,
}
