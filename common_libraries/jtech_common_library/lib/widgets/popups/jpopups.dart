import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/popups/jdialog.dart';
import 'package:jtech_common_library/widgets/popups/jsheet.dart';
import 'package:jtech_common_library/widgets/popups/jtoast.dart';

/*
* 弹出层入口方法
* @author wuxubaiyang
* @Time 2021/7/8 下午1:50
*/
@protected
class JPopups {
  static final JPopups _instance = JPopups._internal();

  factory JPopups() => _instance;

  JPopups._internal();

  //创建dialog对象
  final dialog = JDialog();

  //创建sheet对象
  final sheet = JSheet();

  //toast消息提示
  final toast = JToast();

  //初始化方法
  Future init() async {}
}
