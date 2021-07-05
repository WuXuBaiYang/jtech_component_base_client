import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/*
* 有状态组件基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:26
*/
abstract class BaseStatefulWidget extends StatefulWidget {
  //持有页面基类状态
  final _BaseStatefulWidgetState _state;

  BaseStatefulWidget({Key? key})
      : _state = _BaseStatefulWidgetState(),
        super(key: key);

  @override
  createState() => _state;

  //构建视图
  Widget build(BuildContext context);

  //刷新页面
  void refreshUI(VoidCallback fun) {
    _state.refreshUI(fun);
  }

  //初始化方法
  @mustCallSuper
  void initState() {}

  //销毁方法
  @mustCallSuper
  void dispose() {}
}

/*
* 页面基类状态实现
* @author wuxubaiyang
* @Time 2021/6/30 下午1:19
*/
class _BaseStatefulWidgetState extends State<BaseStatefulWidget> {
  @override
  void initState() {
    super.initState();
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  //刷新UI
  @protected
  void refreshUI(VoidCallback fun) {
    if (mounted) setState(fun);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }
}
