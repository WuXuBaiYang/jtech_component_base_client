import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:image_editor/image_editor.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片编辑控制器
* @author jtechjh
* @Time 2021/9/3 2:24 下午
*/
class ImageEditorController extends BaseController {
  //编辑控制key
  final GlobalKey<ExtendedImageEditorState> _editorKey;

  ImageEditorController() : _editorKey = GlobalKey();

  //获取图片编辑控制key
  GlobalKey<ExtendedImageEditorState> get editorKey => _editorKey;

  //顺时针旋转90度
  void rotateRight90() => _editorKey.currentState?.rotate(right: true);

  //逆时针旋转90度
  void rotateLeft90() => _editorKey.currentState?.rotate(right: false);

  //镜像翻转
  void flip() => _editorKey.currentState?.flip();

  //重置状态
  void reset() => _editorKey.currentState?.reset();

  //执行裁剪并获取到裁剪后的数据
  Future<JFileInfo?> cropImage() async {
    var currentState = _editorKey.currentState;
    if (null == currentState) return null;
    var cropRect = currentState.getCropRect();
    var imageData = currentState.rawImageData;
    var action = currentState.editAction;
    if (null == action) return null;
    var rotateAngle = action.rotateAngle.toInt();
    var flipHorizontal = action.flipY;
    var flipVertical = action.flipX;
    ImageEditorOption editorOption = ImageEditorOption();
    //添加裁剪方法
    if (action.needCrop && null != cropRect) {
      editorOption.addOption(ClipOption.fromRect(cropRect));
    }
    //添加镜像翻转方法
    if (action.needFlip) {
      editorOption.addOption(FlipOption(
        horizontal: flipHorizontal,
        vertical: flipVertical,
      ));
    }
    //添加旋转方法
    if (action.hasRotateAngle) {
      editorOption.addOption(RotateOption(rotateAngle));
    }
    var result = await ImageEditor.editImage(
      image: imageData,
      imageEditorOption: editorOption,
    );
    if (null == result) return null;
    return JFileInfo.fromMemory(
      result,
      fileName:  "${jTools.generateID()}.jpeg",
      cachePath: await jFile.getImageCacheDirPath(),
    );
  }
}

/*
* 图片手势控制器
* @author jtechjh
* @Time 2021/9/3 2:24 下午
*/
class ImageGestureController extends BaseController {
  //手势管理key
  final GlobalKey<ExtendedImageGestureState> _gestureKey;

  ImageGestureController() : _gestureKey = GlobalKey();

  //获取图片手势管理key
  GlobalKey<ExtendedImageGestureState> get gestureKey => _gestureKey;

  //重置状态
  void reset() => _gestureKey.currentState?.reset();

  //滑动
  void slide() => _gestureKey.currentState?.slide();

  //图片缩放
  void scale({double? scale, Offset? position}) => _gestureKey.currentState
      ?.handleDoubleTap(scale: scale, doubleTapPosition: position);
}
