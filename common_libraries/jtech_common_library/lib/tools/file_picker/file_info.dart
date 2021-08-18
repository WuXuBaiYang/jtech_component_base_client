import 'dart:io';
import 'package:jtech_common_library/jcommon.dart';

/*
* 选择器返回值
* @author jtechjh
* @Time 2021/7/30 5:42 下午
*/
class JPickerResult {
  //已选择文件集合
  final List<JFileInfo> files;

  JPickerResult({
    required this.files,
  });

  //判断是否为空
  bool get isEmpty => files.isEmpty;

  //判断是否为单文件
  bool get isSingle => files.length == 1;

  //获取文件数量
  int get length => files.length;

  //获取单文件
  JFileInfo? get singleFile {
    if (isSingle) return files.first;
  }
}

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

  //文件后缀
  String? suffixes;

  JFileInfo({
    required this.path,
    this.name,
    this.length,
    this.suffixes,
  });

  //从文件路径中加载
  static Future<JFileInfo> fromPath(String path) => fromFile(File(path));

  //从文件中加载
  static Future<JFileInfo> fromFile(File file) async => JFileInfo(
        path: file.path,
        length: await file.length(),
        name: file.name,
        suffixes: file.suffixes,
      );

  //获取为file类型
  File get file => File(path);

  //判断文件类型是否为图片
  bool get isImageType => jMatches.isImageFile(path);

  //判断文件类型是否为视频
  bool get isVideoType => jMatches.isVideoFile(path);

  //判断文件类型是否为音频
  bool get isAudioType => jMatches.isAudioFile(path);
}
