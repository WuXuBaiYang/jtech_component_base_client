import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 文件选择器
* @author jtechjh
* @Time 2021/8/18 4:21 下午
*/
class JFilePicker extends BaseManage {
  static final JFilePicker _instance = JFilePicker._internal();

  factory JFilePicker() => _instance;

  JFilePicker._internal();

  @override
  Future<void> init() async {}

  //附件选择基础方法
  Future<JPickerResult?> pick(
    BuildContext context, {
    required List<PickerMenuItem> items,
    int maxCount = 1,
    //当只有一个选项的时候，是否显示sheet
    bool showSheetOnlyOne = false,
  }) async {
    if (items.isEmpty) return null;
    if (showSheetOnlyOne && items.length == 1) {
      return _doPick(context, items.first, maxCount);
    }
    return jSheet.showCustomBottomSheet<JPickerResult>(
      context,
      config: SheetConfig(
        content: ListView.separated(
          separatorBuilder: (_, __) => Divider(),
          itemCount: items.length,
          itemBuilder: (_, index) {
            var item = items[index];
            return ListTile(
              leading: item.leading,
              title: item.title,
              subtitle: item.subTitle,
              onTap: () => _doPick(context, item, maxCount),
            );
          },
        ),
      ),
    );
  }

  //执行pick方法
  Future<JPickerResult?> _doPick(
    BuildContext context,
    PickerMenuItem item,
    int maxCount,
  ) async {
    item.onPress?.call();
    List<JFileInfo>? files;
    switch (item.type) {
      case PickerType.image:
        files = await _doPickFiles(
          FileType.image,
          item.allowedExtensions,
          maxCount,
        );
        break;
      case PickerType.imageTake:
        files = await CameraPage.takePhoto(
          maxCount: maxCount,
          resolution: item.resolution,
        );
        break;
      case PickerType.video:
        files = await _doPickFiles(
          FileType.video,
          item.allowedExtensions,
          maxCount,
        );
        break;
      case PickerType.videoRecord:
        files = await CameraPage.recordVideo(
          maxCount: maxCount,
          maxRecordDuration: item.maxRecordDuration,
          resolution: item.resolution,
        );
        break;
      case PickerType.audio:
        files = await _doPickFiles(
          FileType.audio,
          item.allowedExtensions,
          maxCount,
        );
        break;
      case PickerType.audioRecord:
        files = await _showAudioRecordSheet(
          context,
          item.maxRecordDuration,
          maxCount,
        );
        break;
      case PickerType.custom:
        files = await _doPickFiles(
          FileType.custom,
          item.allowedExtensions,
          maxCount,
        );
        break;
    }
    if (null != files && files.isNotEmpty) {
      return JPickerResult(files: files);
    }
  }

  //选择文件方法
  Future<List<JFileInfo>?> _doPickFiles(
    FileType type,
    List<String>? allowedExtensions,
    int maxCount,
  ) async {
    var result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      allowCompression: false,
      allowMultiple: maxCount > 1,
    );
    if (null != result) {
      List<JFileInfo> files = [];
      for (var f in result.files) {
        if (--maxCount < 0) break;
        if (null == f.path) continue;
        files.add(await JFileInfo.fromPath(f.path!));
      }
      return files;
    }
  }

  //弹出音频录制底部弹层
  Future<List<JFileInfo>?> _showAudioRecordSheet(
    BuildContext context,
    Duration? maxDuration,
    int maxCount,
  ) {
    var controller = JAudioRecordController(
      maxRecordCount: maxCount,
      maxDuration: maxDuration,
    );
    return jSheet.showCustomBottomSheet<List<JFileInfo>>(
      context,
      config: SheetConfig(
        content: JAudioRecord.full(
          controller: controller,
          elevation: 0,
        ),
        title: Text("录制音频文件"),
        confirmItem: Icon(Icons.done),
        confirmTap: () {
          if (controller.audioFiles.isNotEmpty) {
            return controller.audioFiles;
          }
        },
      ),
    );
  }
}

//单例调用
final jFilePicker = JFilePicker();
