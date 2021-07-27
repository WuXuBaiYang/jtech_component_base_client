/*
* 选择文件信息
* @author wuxubaiyang
* @Time 2021/7/26 下午1:42
*/
import 'package:file_picker/file_picker.dart';

class FileItem {
  //文件名称
  String name;

  //路径
  String path;

  //文件大小
  int size;

  FileItem({
    required this.path,
    required this.name,
    required this.size,
  });
}

/*
* 文件选择菜单子项
* @author wuxubaiyang
* @Time 2021/7/26 下午1:46
*/
class FilePickerMenuItem {
  //名称
  String name;

  //类型(当类型为空的时候，则代表当前菜单必然包含子菜单)
  FilePickerType? type;

  //子菜单集合
  List<FilePickerMenuItem> children;

  //文件类型通过格式集合
  List<String> extensions;

  FilePickerMenuItem({
    this.name = "",
    this.type,
    this.children = const [],
    this.extensions = const [],
  }) : assert(
          !(null == type && children.isEmpty),
          "当类型为空时，必须包含子菜单元素",
        );

  //创建图片选择项
  FilePickerMenuItem.image({
    this.name = "图片选择",
    bool imagePick = true,
    String imagePickName = "相册",
    bool imageTake = true,
    String imageTakeName = "拍照",
    this.extensions = const [],
  }) : this.children = [] {
    if (imagePick) {
      children.add(FilePickerMenuItem(
        name: imagePickName,
        type: FilePickerType.imagePick,
      ));
    }
    if (imageTake) {
      children.add(FilePickerMenuItem(
        name: imageTakeName,
        type: FilePickerType.imageTake,
      ));
    }
  }

  //创建视频选择项
  FilePickerMenuItem.video({
    this.name = "视频选择",
    bool videoPick = true,
    String videoPickName = "相册",
    bool videoRecord = true,
    String videoRecordName = "录制",
    this.extensions = const [],
  }) : this.children = [] {
    if (videoPick) {
      children.add(FilePickerMenuItem(
        name: videoPickName,
        type: FilePickerType.videoPick,
      ));
    }
    if (videoRecord) {
      children.add(FilePickerMenuItem(
        name: videoRecordName,
        type: FilePickerType.videoRecord,
      ));
    }
  }

  //创建音频选择项
  FilePickerMenuItem.audio({
    this.name = "音频选择",
    bool audioPick = true,
    String audioPickName = "本地",
    bool audioRecord = true,
    String audioRecordName = "录制",
    this.extensions = const [],
  }) : this.children = [] {
    if (audioPick) {
      children.add(FilePickerMenuItem(
        name: audioPickName,
        type: FilePickerType.audioPick,
      ));
    }
    if (audioRecord) {
      children.add(FilePickerMenuItem(
        name: audioRecordName,
        type: FilePickerType.audioRecord,
      ));
    }
  }

  //创建自定义格式选择项
  FilePickerMenuItem.custom({
    this.name = "自定义文件选择",
    this.type = FilePickerType.custom,
    this.extensions = const [],
  }) : this.children = [];
}

/*
* 文件选择类型
* @author wuxubaiyang
* @Time 2021/7/26 下午1:47
*/
enum FilePickerType {
  imagePick,
  imageTake,
  videoPick,
  videoRecord,
  audioPick,
  audioRecord,
  custom,
}

/*
* 扩展文件选择类型
* @author wuxubaiyang
* @Time 2021/7/27 上午10:23
*/
extension FilePickerTypeExtension on FilePickerType {
  //获取文件选择类型
  FileType? getFileType() {
    switch (this) {
      case FilePickerType.imagePick:
        return FileType.image;
      case FilePickerType.videoPick:
        return FileType.video;
      case FilePickerType.audioPick:
        return FileType.audio;
      case FilePickerType.custom:
        return FileType.custom;
      case FilePickerType.imageTake:
      case FilePickerType.videoRecord:
      case FilePickerType.audioRecord:
        break;
    }
    return null;
  }
}
