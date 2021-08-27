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

  //判断是否非空
  bool get isNoEmpty => files.isNotEmpty;

  //判断是否为单文件
  bool get isSingle => files.length == 1;

  //获取文件数量
  int get length => files.length;

  //获取单文件
  JFileInfo? get singleFile {
    if (isSingle) return files.first;
  }

  //转换为接口请求的文件集合类型
  List<RequestFileItem> toRequestFiles() => files
      .map<RequestFileItem>((item) => RequestFileItem(
            filePath: item.uri,
            filename: item.name,
          ))
      .toList();
}

/*
* 单文件信息
* @author jtechjh
* @Time 2021/7/30 5:42 下午
*/
class JFileInfo {
  //文件地址
  String uri;

  //文件名称
  String? name;

  //文件大小
  int? length;

  //文件后缀
  String? suffixes;

  JFileInfo({
    required this.uri,
    this.name,
    this.length,
    this.suffixes,
  });

  //从网络地址中加载
  static Future<JFileInfo> fromUrl(String url) async => JFileInfo(
        uri: url,
      );

  //从文件路径中加载
  static Future<JFileInfo> fromPath(String path) => fromFile(File(path));

  //从文件中加载
  static Future<JFileInfo> fromFile(File file) async => JFileInfo(
        uri: file.path,
        length: await file.length(),
        name: file.name,
        suffixes: file.suffixes,
      );

  //获取为file类型
  File get file => File(uri);

  //判断是否为本地文件
  bool get isLocalFile => !isNetFile;

  //网络地址判断正则
  final _netFileRegExp = RegExp(r"http://|https://");

  //判断是否为网络文件
  bool get isNetFile => uri.startsWith(_netFileRegExp);

  //判断文件类型是否为图片
  bool get isImageType => jMatches.isImageFile("$uri$suffixes");

  //判断文件类型是否为视频
  bool get isVideoType => jMatches.isVideoFile("$uri$suffixes");

  //判断文件类型是否为音频
  bool get isAudioType => jMatches.isAudioFile("$uri$suffixes");
}
