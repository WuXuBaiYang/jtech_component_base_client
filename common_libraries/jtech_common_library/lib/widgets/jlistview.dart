import 'package:flutter/cupertino.dart';

/*
* 通用列表组件
* @author wuxubaiyang
* @Time 2021/7/2 下午5:20
*/
class JListView extends StatefulWidget {
  //是否启用下拉刷新
  final bool enablePullDown;

  //是否启用上拉加载
  final bool enablePullUp;

  const JListView({
    Key? key,
    this.enablePullDown = false,
    this.enablePullUp = false,
  }) : super(key: key);

  //判断是否存在刷新事件
  bool get hasRefreshing => enablePullDown || enablePullUp;

  @override
  State<StatefulWidget> createState() =>
      hasRefreshing ? _JListViewRefreshingState() : _JListViewState();
}

/*
* 默认列表状态
* @author wuxubaiyang
* @Time 2021/7/2 下午5:20
*/
class _JListViewState extends State<JListView> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

/*
* 刷新列表状态
* @author wuxubaiyang
* @Time 2021/7/2 下午5:31
*/
class _JListViewRefreshingState extends State<JListView> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
