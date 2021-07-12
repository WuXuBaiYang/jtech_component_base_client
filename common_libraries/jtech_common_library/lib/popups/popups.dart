import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jdialog.dart';
import 'jsheet.dart';
import 'jsnack.dart';
import 'jtoast.dart';

/*
* 弹出层入口方法
* @author wuxubaiyang
* @Time 2021/7/8 下午1:50
*/
@protected
class Popups {
  //创建dialog对象
  final dialog = JDialog();

  //创建sheet对象
  final sheet = JSheet();

  //toast消息提示
  final toast = JToast();

  //snack消息提示
  final snack = JSnack();

  //初始化方法
  Future init() async {}
}
