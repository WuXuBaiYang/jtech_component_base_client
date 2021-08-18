import 'dart:io';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:path_provider/path_provider.dart';

/*
* 文件操作工具
* @author wuxubaiyang
* @Time 2021/7/26 下午3:04
*/
class JFile extends BaseManage {
  static final JFile _instance = JFile._internal();

  factory JFile() => _instance;

  JFile._internal();

  @override
  Future<void> init() async {}

  //图片缓存目录
  static final String imageCachePath = "imageCache/";

  //视频缓存目录
  static final String videoCachePath = "videoCache/";

  //音频缓存目录
  static final String audioCachePath = "audioCache/";

  //清除视频缓存目录文件
  Future<bool> clearVideoCache() async {
    return clearCache(path: videoCachePath);
  }

  //清除图片缓存目录文件
  Future<bool> clearImageCache() async {
    return clearCache(path: imageCachePath);
  }

  //清除缓存目录文件
  Future<bool> clearCache({String path = ""}) async {
    var dir = Directory(await getCacheDirPath(path: path));
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
    return true;
  }

  //获取音频缓存目录大小
  Future<String> getAudioCacheSize({
    bool lowerCase = false,
    int fixed = 1,
  }) {
    return getCacheSize(
      path: audioCachePath,
      lowerCase: lowerCase,
      fixed: fixed,
    );
  }

  //获取视频缓存目录大小
  Future<String> getVideoCacheSize({
    bool lowerCase = false,
    int fixed = 1,
  }) {
    return getCacheSize(
      path: videoCachePath,
      lowerCase: lowerCase,
      fixed: fixed,
    );
  }

  //获取图片缓存目录大小
  Future<String> getImageCacheSize({
    bool lowerCase = false,
    int fixed = 1,
  }) {
    return getCacheSize(
      path: imageCachePath,
      lowerCase: lowerCase,
      fixed: fixed,
    );
  }

  //获取缓存大小
  Future<String> getCacheSize({
    String path = "",
    bool lowerCase = false,
    int fixed = 1,
  }) async {
    var dir = await getCacheDirPath(path: path);
    var result = await getDirectorySize(dir);
    return getFileSize(result, lowerCase: lowerCase, fixed: fixed);
  }

  //迭代计算一个目录的大小
  Future<int> getDirectorySize(String path, {int size = 0}) async {
    var items = Directory(path).listSync(recursive: true, followLinks: true);
    for (var item in items) {
      if (item is File) {
        size += await item.length();
      } else if (item is Directory) {
        size = await getDirectorySize(item.absolute.path, size: size);
      }
    }
    return size;
  }

  //文件大小对照表
  final Map<int, String> _fileSizeMap = {
    1024 * 1024 * 1024 * 1024: "TB",
    1024 * 1024 * 1024: "GB",
    1024 * 1024: "MB",
    1024: "KB",
    0: "B",
  };

  //文件大小格式转换
  String getFileSize(
    int size, {
    bool lowerCase = false,
    int fixed = 1,
  }) {
    for (var item in _fileSizeMap.keys) {
      if (size >= item) {
        var result = (size / item).toStringAsFixed(fixed);
        var unit = _fileSizeMap[item];
        if (lowerCase) unit = unit!.toLowerCase();
        return "$result$unit";
      }
    }
    return "";
  }

  //获取本地缓存文件目录
  Future<String> getCacheDirPath({String path = ""}) async {
    var dir = await getTemporaryDirectory();
    dir = Directory(join(dir.path, path));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir.path;
  }

  //获取图片缓存路径
  Future<String> getImageCacheDirPath() =>
      getCacheDirPath(path: imageCachePath);

  //获取图片缓存文件地址
  Future<String> getImageCacheFilePath(String fileName,
      {bool create = true}) async {
    if (fileName.isEmpty) return fileName;
    var dirPath = await getImageCacheDirPath();
    var file = File(join(dirPath, fileName));
    if (create && !file.existsSync()) file.createSync(recursive: true);
    return file.path;
  }

  //获取视频缓存路径
  Future<String> getVideoCacheDirPath() =>
      getCacheDirPath(path: videoCachePath);

  //获取视频缓存文件地址
  Future<String> getVideoCacheFilePath(String fileName,
      {bool create = true}) async {
    if (fileName.isEmpty) return fileName;
    var dirPath = await getVideoCacheDirPath();
    var file = File(join(dirPath, fileName));
    if (create && !file.existsSync()) file.createSync(recursive: true);
    return file.path;
  }

  //获取音频缓存路径
  Future<String> getAudioCacheDirPath() =>
      getCacheDirPath(path: audioCachePath);

  //获取音频缓存文件地址
  Future<String> getAudioCacheFilePath(String fileName,
      {bool create = true}) async {
    if (fileName.isEmpty) return fileName;
    var dirPath = await getAudioCacheDirPath();
    var file = File(join(dirPath, fileName));
    if (create && !file.existsSync()) file.createSync(recursive: true);
    return file.path;
  }
}

//单例调用
final jFile = JFile();

/*
* 扩展文件方法
* @author jtechjh
* @Time 2021/8/18 10:51 上午
*/
extension FileExtension on File {
  //获取文件名
  String? get name {
    var index = path.lastIndexOf(r'/');
    if (index >= 0 && index < path.length) {
      return path.substring(index + 1);
    }
  }

  //获取文件后缀
  String? get suffixes {
    var index = path.lastIndexOf(r'.');
    var sepIndex = path.lastIndexOf(r'/');
    if (index >= 0 && index <= path.length && index > sepIndex) {
      return path.substring(index);
    }
  }
}
