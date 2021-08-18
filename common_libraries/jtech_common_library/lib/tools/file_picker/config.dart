import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/tools/file_picker/process/audio/audio.dart';

/*
* 选择器菜单子项
* @author jtechjh
* @Time 2021/8/18 4:56 下午
*/
class PickerMenuItem<T extends BaseFileProcess> {
  //标题
  final Widget title;

  //副标题
  final Widget? subTitle;

  //头部图标
  final Widget? leading;

  //选择文件类型
  final PickerType type;

  //自定义类型时，使用扩展判断
  final List<String> extensions;

  //文件处理方法集合(顺序执行)
  final List<T> process;

  //选项触发回调
  final VoidCallback? onPress;

  PickerMenuItem({
    required this.title,
    required this.type,
    this.extensions = const [],
    this.process = const [],
    this.subTitle,
    this.leading,
    this.onPress,
  });

  //图片选择
  static PickerMenuItem<BaseImageProcess> image({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseImageProcess>? process,
    VoidCallback? onPress,
    //图片处理部分参数
    bool compress = true,
    bool crop = false,
  }) {
    process ??= [];
    if (compress) process.add(ImageCompress());
    if (crop) process.add(ImageCrop());
    return PickerMenuItem(
      title: title ?? Text("图片选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.image,
      process: process,
      onPress: onPress,
    );
  }

  //图片拍摄
  static PickerMenuItem<BaseImageProcess> imageTake({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseImageProcess>? process,
    VoidCallback? onPress,
    //图片处理部分参数
    bool compress = true,
    bool crop = false,
  }) {
    process ??= [];
    if (compress) process.add(ImageCompress());
    if (crop) process.add(ImageCrop());
    return PickerMenuItem(
      title: title ?? Text("图片拍摄"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.imageTake,
      process: process,
      onPress: onPress,
    );
  }

  //视频选择
  static PickerMenuItem<BaseVideoProcess> video({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseVideoProcess>? process,
    VoidCallback? onPress,
    //视频处理部分参数
    bool compress = true,
  }) {
    process ??= [];
    if (compress) process.add(VideoCompress());
    return PickerMenuItem(
      title: title ?? Text("视频选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.video,
      process: process,
      onPress: onPress,
    );
  }

  //视频录制
  static PickerMenuItem<BaseVideoProcess> videoRecord({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseVideoProcess>? process,
    VoidCallback? onPress,
    //视频处理部分参数
    bool compress = true,
  }) {
    process ??= [];
    if (compress) process.add(VideoCompress());
    return PickerMenuItem(
      title: title ?? Text("视频录制"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.videoRecord,
      process: process,
      onPress: onPress,
    );
  }

  //音频选择
  static PickerMenuItem<BaseAudioProcess> audio({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    VoidCallback? onPress,
  }) {
    process ??= [];
    return PickerMenuItem(
      title: title ?? Text("音频选择"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.audio,
      process: process,
      onPress: onPress,
    );
  }

  //音频录制
  static PickerMenuItem<BaseAudioProcess> audioRecord({
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    VoidCallback? onPress,
  }) {
    process ??= [];
    return PickerMenuItem(
      title: title ?? Text("音频录制"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.audioRecord,
      process: process,
      onPress: onPress,
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
    required List<String> extensions,
    VoidCallback? onPress,
  }) {
    process ??= [];
    return PickerMenuItem(
      title: title ?? Text("自定义类型"),
      subTitle: subTitle,
      leading: leading,
      type: PickerType.custom,
      process: process,
      extensions: extensions,
      onPress: onPress,
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
