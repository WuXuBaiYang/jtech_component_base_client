import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/*
* 有状态组件基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:26
*/
abstract class BaseStatefulWidget<T extends BaseStatefulWidgetState>
    extends StatefulWidget {
  //当前组件持有key
  final GlobalKey<T> key;

  BaseStatefulWidget({GlobalKey<T>? key})
      : key = key ?? GlobalKey(),
        super(key: key);

  //是否持有state
  get wantKeepAlive => false;

  @override
  BaseStatefulWidgetState createState() => BaseStatefulWidgetState();

  //构建视图
  Widget build(BuildContext context);

  //刷新页面
  void refreshUI([VoidCallback? fun]) => key.currentState?.refreshUI(fun);

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
class BaseStatefulWidgetState extends State<BaseStatefulWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  void initState() {
    super.initState();
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.build(context);
  }

  //刷新UI
  @protected
  void refreshUI(VoidCallback? fun) {
    if (mounted) setState(fun ?? () {});
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }
}
