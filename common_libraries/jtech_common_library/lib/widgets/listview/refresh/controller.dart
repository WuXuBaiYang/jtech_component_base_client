import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';

//刷新状态变化回调
typedef OnRefreshStateChange = void Function(RefreshState state);

/*
* 刷新列表组件控制器
* @author wuxubaiyang
* @Time 2021/7/7 上午11:25
*/
class JRefreshListViewController<V> extends JListViewController<V> {
  //页码累积数量
  final int pageAddStep;

  //分页-单页数据量
  final int pageSize;

  //分页-默认初始页面
  final int initPageIndex;

  //分页-页码
  int pageIndex;

  //刷新状态
  ValueChangeNotifier<RefreshState> _refreshState;

  JRefreshListViewController({
    this.initPageIndex = 1,
    this.pageSize = 15,
    this.pageAddStep = 1,
  })  : pageIndex = initPageIndex,
        _refreshState = ValueChangeNotifier(RefreshState.None);

  //页码增加
  void addPageIndex({int? addStep}) => pageIndex += addStep ?? pageAddStep;

  //初始化页码
  void resetPageIndex() => pageIndex = initPageIndex;

  //根据刷新状态获取请求页码
  int getRequestPageIndex(bool loadMore) =>
      loadMore ? pageIndex + pageAddStep : initPageIndex;

  //添加刷新状态变化监听
  void addRefreshStateChange(OnRefreshStateChange listener) =>
      _refreshState.addListener(() => listener(_refreshState.value));

  //完成操作
  void requestCompleted(List<V> newData, {bool loadMore = false}) {
    if (newData.isEmpty) {
      if (!loadMore) refreshCompleted(newData);
      return loadNoMoreData();
    }
    loadMore ? loadCompleted(newData) : refreshCompleted(newData);
  }

  //刷新完成
  void refreshCompleted(List<V> newData) {
    _refreshState.setValue(RefreshState.RefreshCompleted);
    setData(newData);
    resetPageIndex();
  }

  //加载完成
  void loadCompleted(List<V> newData) {
    _refreshState.setValue(RefreshState.LoadComplete);
    addData(newData);
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
