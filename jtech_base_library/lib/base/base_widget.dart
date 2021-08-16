import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/*
* 有状态组件基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:26
*/
abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => getState();

  BaseState getState();
}

/*
* 有状态组件基类-多状态管理
* @author wuxubaiyang
* @Time 2021/7/5 上午9:26
*/
abstract class BaseStatefulWidgetMultiply extends StatefulWidget {
  //当前状态管理
  final State<BaseStatefulWidgetMultiply> currentState;

  BaseStatefulWidgetMultiply({
    required this.currentState,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => currentState;
}

/*
* 有状态组件-状态基类
* @author wuxubaiyang
* @Time 2021/6/30 下午1:19
*/
abstract class BaseState<T extends StatefulWidget> extends State<T> {}

/*
* 无状态组件基类
* @author jtechjh
* @Time 2021/8/12 5:27 下午
*/
abstract class BaseStatelessWidget extends StatelessWidget {
  BaseStatelessWidget({
    Key? key,
  }) : super(key: key);
}
