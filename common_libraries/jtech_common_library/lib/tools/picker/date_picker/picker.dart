import 'package:jtech_base_library/jbase.dart';

/*
* 日期选择器
* @author jtechjh
* @Time 2021/9/7 3:21 下午
*/
class JDatePicker extends BaseManage {
  static final JDatePicker _instance = JDatePicker._internal();

  factory JDatePicker() => _instance;

  JDatePicker._internal();

  //日期选择基础方法
  Future<List<DateTime>?> picker() async {

  }
}

//单例调用
final jDatePicker = JDatePicker();
