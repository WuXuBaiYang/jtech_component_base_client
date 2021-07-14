import 'package:flutter/cupertino.dart';

/*
* 控制器基类
* @author wuxubaiyang
* @Time 2021/7/14 下午5:09
*/
abstract class BaseController {
  //销毁控制器
  @mustCallSuper
  void dispose() {}
}
