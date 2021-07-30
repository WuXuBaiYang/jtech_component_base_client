import 'dart:io';

// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:video_compress/video_compress.dart';

import '../jcommon.dart';

class MediaTool {
  // //图片压缩
  // Future<File?> compressImage(
  //   File file, {
  //   String? targetFileName,
  //   String? targetPath,
  //   int quality = 75,
  //   int rotate = 0,
  //   ImageCompressFormat format = ImageCompressFormat.jpeg,
  // }) async {
  //   targetFileName ??= "${jCommon.tools.generateID()}.${format.text()}";
  //   targetPath ??=
  //       await jCommon.tools.file.getImageCacheFilePath(targetFileName);
  //   return await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: quality,
  //     rotate: rotate,
  //     format: format.type(),
  //   );
  // }
  //
  // //视频压缩
  // Future<File?> compressVideo(
  //   File file, {
  //   bool deleteOrigin = false,
  //   int frameRate = 30,
  // }) async {
  //   var result = await VideoCompress.compressVideo(
  //     file.absolute.path,
  //     quality: VideoQuality.DefaultQuality,
  //     deleteOrigin: deleteOrigin,
  //     frameRate: frameRate,
  //   );
  //   return result?.file;
  // }
  //
  // //获取视频缩略图
  // Future<File> getVideoThumbnail(
  //   File file, {
  //   int quality = 75,
  //   int position = -1,
  // }) async {
  //   return await VideoCompress.getFileThumbnail(
  //     file.absolute.path,
  //     quality: quality,
  //     position: position,
  //   );
  // }
}

/*
* 图片压缩支持的文件格式
* @author wuxubaiyang
* @Time 2021/7/26 下午3:08
*/
enum ImageCompressFormat {
  jpeg,
  png,
}

/*
* 扩展图片压缩支持格式方法
* @author wuxubaiyang
* @Time 2021/7/26 下午3:09
*/
extension ImageCompressFormatExtension on ImageCompressFormat {
  //获取格式化文件类型
  // CompressFormat type() {
  //   switch (this) {
  //     case ImageCompressFormat.jpeg:
  //       return CompressFormat.jpeg;
  //     case ImageCompressFormat.png:
  //       return CompressFormat.png;
  //   }
  // }

  //获取格式化文件文本类型
  String text() {
    switch (this) {
      case ImageCompressFormat.jpeg:
        return "jpeg";
      case ImageCompressFormat.png:
        return "png";
    }
  }
}
