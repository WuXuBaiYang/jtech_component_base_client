import 'package:jtech_base_library/jbase.dart';
/*
* 地址选择器
* @author jtechjh
* @Time 2021/9/7 3:21 下午
*/
class JAddressPicker extends BaseManage{
  static final JAddressPicker _instance = JAddressPicker._internal();

  factory JAddressPicker() => _instance;

  JAddressPicker._internal();
}

//单例调用
final jAddressPicker = JAddressPicker();
