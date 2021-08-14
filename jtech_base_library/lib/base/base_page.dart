import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 有状态页面基类
* @author wuxubaiyang
* @Time 2021/7/5 上午9:27
*/
abstract class BaseStatefulPage extends BaseStatefulWidget {}

/*
* 有状态页面基类-多状态
* @author wuxubaiyang
* @Time 2021/7/5 上午9:27
*/
abstract class BaseStatefulPageMultiply extends BaseStatefulWidgetMultiply {
  BaseStatefulPageMultiply({
    required State<BaseStatefulPageMultiply> currentState,
  }) : super(currentState: currentState);
}

/*
* 无状态页面基类
* @author jtechjh
* @Time 2021/8/12 5:28 下午
*/
abstract class BaseStatelessPage extends BaseStatelessWidget {}
