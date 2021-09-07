import 'package:jtech_common_library/jcommon.dart';

/*
* 文件处理基类
* @author jtechjh
* @Time 2021/8/18 4:33 下午
*/
abstract class BaseFileProcess {
  //执行操作
  Future<JFileInfo> process(JFileInfo fileInfo);
}
