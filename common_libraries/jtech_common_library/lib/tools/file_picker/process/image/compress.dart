import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片压缩方法
* @author jtechjh
* @Time 2021/8/18 4:40 下午
*/
class ImageCompress extends BaseImageProcess {
  //压缩率
  final int quality;

  //目标路径
  final String? path;

  ImageCompress({
    this.quality = 75,
    this.path,
  });

  @override
  Future<JFileInfo> process(JFileInfo fileInfo) async {
    var compressPath = path ?? await jFile.getImageCacheDirPath();
    var result = await FlutterImageCompress.compressAndGetFile(
      fileInfo.uri,
      join(compressPath, jTools.generateID(), ".jpeg"),
      quality: quality,
    );
    if (null == result) return fileInfo;
    return JFileInfo.fromFile(result);
  }
}
