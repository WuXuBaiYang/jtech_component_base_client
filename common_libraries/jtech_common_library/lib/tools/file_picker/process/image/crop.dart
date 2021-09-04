import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片裁剪方法
* @author jtechjh
* @Time 2021/8/18 4:40 下午
*/
class ImageCrop extends BaseImageProcess {
  //最大缩放比例
  final double maxScale;

  //初始化裁剪比例
  final double? initialCropRatio;

  //是否启用裁剪比例菜单
  final bool enableRatioMenu;

  ImageCrop({
    this.maxScale = 3.0,
    this.initialCropRatio,
    this.enableRatioMenu = false,
  });

  @override
  Future<JFileInfo> process(JFileInfo fileInfo) async {
    var result = await jRouter.push<JFileInfo>(ImageEditorPagePage(
      ImageDataSource.fileInfo(
        fileInfo,
        cacheRawData: true,
      ),
      maxScale: maxScale,
      initialCropRatio: initialCropRatio,
      enableRatioMenu: enableRatioMenu,
    ));
    return result ?? fileInfo;
  }
}
