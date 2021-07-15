import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog/dialog.dart' as j;
import 'sheet/sheet.dart';
import 'snack/snack.dart';
import 'toast/toast.dart';

/*
* 弹出层入口方法
* @author wuxubaiyang
* @Time 2021/7/8 下午1:50
*/
@protected
class Popups {
  //创建dialog对象
  final dialog = j.Dialog();

  //创建sheet对象
  final sheet = Sheet();

  //toast消息提示
  final toast = Toast();

  //snack消息提示
  final snack = Snack();

  //初始化方法
  Future init() async {}
}
