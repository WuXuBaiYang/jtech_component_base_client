import 'package:jtech_base_library/jbase.dart';

/*
* 预览工具方法
* @author jtechjh
* @Time 2021/8/23 10:12 上午
*/
class JPreview extends BaseManage {
  static final JPreview _instance = JPreview._internal();

  factory JPreview() => _instance;

  JPreview._internal();

  @override
  Future<void> init() async {}
}

//单例调用
final jPreview = JPreview();
