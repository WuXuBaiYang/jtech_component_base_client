import 'dart:io';

/*
* 选择器返回值
* @author jtechjh
* @Time 2021/7/30 5:42 下午
*/
class JPickerResult {}

/*
* 单文件信息
* @author jtechjh
* @Time 2021/7/30 5:42 下午
*/
class JFileInfo {
  //文件路径
  String path;

  //文件名称
  String? name;

  //文件大小
  int? length;

  //文件类型
  String? mimeType;

  JFileInfo({
    required this.path,
    this.name,
    this.length,
    this.mimeType,
  });
}
