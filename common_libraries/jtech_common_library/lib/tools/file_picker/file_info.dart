import 'dart:io';

import 'package:camera/camera.dart';
import 'package:jtech_common_library/jcommon.dart';

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
    String? name,
    this.length,
    String? mimeType,
  })  : this.name = name ?? path.substring(path.lastIndexOf(r"\/")),
        this.mimeType = mimeType ?? name?.substring(name.lastIndexOf(r"\."));

  //获取为file类型
  File get file => File(path);

  //判断文件类型是否为图片
  bool get isImageType => jMatches.isImageFile(path);

  //获取图片缩略图
  Future<File> getImageThumbnail() async {
    ///待完成
    return File(path);
  }

  //判断文件类型是否为视频
  bool get isVideoType => jMatches.isVideoFile(path);

  //获取视频缩略图
  Future<File> getVideoThumbnail() async {
    ///待完成
    return File(path);
  }

  //从xFile中加载数据
  static Future<JFileInfo> loadFromXFile(XFile xFile) async => JFileInfo(
        path: xFile.path,
        name: xFile.name,
        length: await xFile.length(),
        mimeType: xFile.mimeType,
      );
}
