import 'package:jtech_base_library/jbase.dart';

import 'dialog/dialog.dart';
import 'sheet/sheet.dart';
import 'snack/snack.dart';
import 'toast/toast.dart';

/*
* 弹出层入口方法
* @author wuxubaiyang
* @Time 2021/7/8 下午1:50
*/
class JPopups extends BaseManage {
  static final JPopups _instance = JPopups._internal();

  factory JPopups() => _instance;

  JPopups._internal();

  //创建dialog对象
  final dialog = JDialog();

  //创建sheet对象
  final sheet = JSheet();

  //toast消息提示
  final toast = JToast();

  //snack消息提示
  final snack = JSnack();

  //初始化方法
  @override
  Future init() async {
    //初始化对话框方法
    await dialog.init();
    //初始化底部弹窗方法
    await sheet.init();
    //初始化toast消息方法
    await toast.init();
    //初始化snack消息方法
    await snack.init();
  }
}

//单例调用
final jPopups = JPopups();
