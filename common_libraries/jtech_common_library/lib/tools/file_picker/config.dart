import 'dart:io';

//附件选择后处理方法回调
typedef OnFilePickHandle = Future<File> Function(File file);

/*
* 附件选择参数配置
* @author jtechjh
* @Time 2021/7/30 1:55 下午
*/
class JPickerConfig {
  //附件选择后的处理方法回调
  final OnFilePickHandle? filePickHandle;

  //附件类型
  final JPickerType type;

  JPickerConfig({
    required this.type,
    this.filePickHandle,
  });
}

/*
* 附件类型枚举
* @author jtechjh
* @Time 2021/7/30 1:58 下午
*/
enum JPickerType {
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
