import 'package:flutter_luban/flutter_luban.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片压缩方法
* @author jtechjh
* @Time 2021/8/18 4:40 下午
*/
class ImageCompress extends BaseImageProcess {
  //压缩率
  final int quality;

  //压缩率步骤
  final int step;

  //目标路径
  final String? path;

  ImageCompress({
    this.quality = 75,
    this.step = 6,
    this.path,
  });

  @override
  Future<JFileInfo> process(JFileInfo fileInfo) async {
    var compressPath = path ?? await jFile.getImageCacheDirPath();
    var result = await Luban.compressImage(CompressObject(
      imageFile: fileInfo.file,
      path: compressPath,
      quality: quality,
      step: step,
      mode: CompressMode.AUTO,
    ));
    if (null != result) {
      fileInfo = await JFileInfo.fromPath(result);
    }
    return fileInfo;
  }
}
