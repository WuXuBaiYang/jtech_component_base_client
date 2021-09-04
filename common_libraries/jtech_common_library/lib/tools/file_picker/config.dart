import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/base/base_menu.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/tools/file_picker/process/audio/audio.dart';

/*
* 选择器菜单子项
* @author jtechjh
* @Time 2021/8/18 4:56 下午
*/
class PickerMenuItem<T extends BaseFileProcess> extends MenuItem {
  //选择文件类型
  final PickerType type;

  //允许通过的文件类型后缀集合
  final List<String>? allowedExtensions;

  //文件处理方法集合(顺序执行)
  final List<T>? process;

  //最大录制时长
  final Duration? maxRecordDuration;

  //使用摄像头清晰度
  final CameraResolution? resolution;

  PickerMenuItem({
    required Widget title,
    required this.type,
    this.allowedExtensions,
    this.process,
    Widget? subTitle,
    Widget? leading,
    VoidCallback? onTap,
    this.maxRecordDuration,
    this.resolution,
  }) : super(
          title: title,
          subTitle: subTitle,
          leading: leading,
          onTap: onTap,
        );

  //图片选择
  static PickerMenuItem<BaseImageProcess> image({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseImageProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
    //图片处理部分参数
    bool compress = false,
    bool crop = false,
  }) {
    process ??= [];
    if (crop) process.add(ImageCrop());
    if (compress) process.add(ImageCompress());
    return PickerMenuItem(
      title: title ?? Text("图片选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.image,
      process: process,
      onTap: onTap,
      allowedExtensions: allowedExtensions,
    );
  }

  //图片拍摄
  static PickerMenuItem<BaseImageProcess> imageTake({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseImageProcess>? process,
    VoidCallback? onTap,
    //图片处理部分参数
    bool compress = false,
    bool crop = false,
    CameraResolution? resolution,
  }) {
    process ??= [];
    if (crop) process.add(ImageCrop());
    if (compress) process.add(ImageCompress());
    return PickerMenuItem(
      title: title ?? Text("图片拍摄"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.imageTake,
      process: process,
      onTap: onTap,
      resolution: resolution,
    );
  }

  //视频选择
  static PickerMenuItem<BaseVideoProcess> video({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseVideoProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
    //视频处理部分参数
    bool compress = false,
  }) {
    process ??= [];
    if (compress) process.add(VideoCompress());
    return PickerMenuItem(
      title: title ?? Text("视频选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.video,
      process: process,
      onTap: onTap,
      allowedExtensions: allowedExtensions,
    );
  }

  //视频录制
  static PickerMenuItem<BaseVideoProcess> videoRecord({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseVideoProcess>? process,
    VoidCallback? onTap,
    //视频处理部分参数
    bool compress = false,
    Duration? maxRecordDuration,
    CameraResolution? resolution,
  }) {
    process ??= [];
    if (compress) process.add(VideoCompress());
    return PickerMenuItem(
      title: title ?? Text("视频录制"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.videoRecord,
      process: process,
      onTap: onTap,
      maxRecordDuration: maxRecordDuration,
      resolution: resolution,
    );
  }

  //音频选择
  static PickerMenuItem<BaseAudioProcess> audio({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
  }) {
    return PickerMenuItem(
      title: title ?? Text("音频选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.audio,
      process: process,
      onTap: onTap,
      allowedExtensions: allowedExtensions,
    );
  }

  //音频录制
  static PickerMenuItem<BaseAudioProcess> audioRecord({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    Duration? maxRecordDuration,
    VoidCallback? onTap,
  }) {
    return PickerMenuItem(
      title: title ?? Text("音频录制"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.audioRecord,
      process: process,
      onTap: onTap,
      maxRecordDuration: maxRecordDuration,
    );
  }

  //自定义类型文件选择
  static PickerMenuItem<BaseFileProcess> custom({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    //自定义类型参数
    required List<String> allowedExtensions,
    VoidCallback? onTap,
  }) {
    return PickerMenuItem(
      title: title ?? Text("自定义类型"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.custom,
      process: process,
      allowedExtensions: allowedExtensions,
      onTap: onTap,
    );
  }
}

/*
* 附件类型枚举
* @author jtechjh
* @Time 2021/7/30 1:58 下午
*/
enum PickerType {
  //图片选择
  image,
  //图片拍照
  imageTake,
  //视频选择
  video,
  //视频录制
  videoRecord,
  //音频选择
  audio,
  //音频录制
  audioRecord,
  //自定义类型
  custom,
}
