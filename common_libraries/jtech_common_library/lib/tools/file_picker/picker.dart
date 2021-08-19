import 'dart:async';

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
    bool canScroll = false,
  }) async {
    if (items.isEmpty) return null;
    if (!showSheetOnlyOne && items.length == 1) {
      return _doPick(context, items.first, maxCount);
    }
    Completer<JPickerResult?> completer = Completer();
    jSheet.showMenuBottomSheet<JPickerResult, PickerMenuItem>(
      context,
      items: items,
      canScroll: canScroll,
      onItemTap: (item, _) async {
        jRouter.pop();
        completer.complete(_doPick(context, item, maxCount));
      },
      contentPadding: EdgeInsets.symmetric(vertical: 15),
    );
    return completer.future;
  }

  //图片选择方法
  Future<JPickerResult?> pickImage(
    BuildContext context, {
    int maxCount = 1,
    bool showSheetOnlyOne = false,
    bool takePhoto = true,
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseImageProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
    //图片处理部分参数
    bool compress = true,
    bool crop = false,
    CameraResolution? resolution,
  }) {
    List<PickerMenuItem> items = [
      PickerMenuItem.image(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        allowedExtensions: allowedExtensions,
        onTap: onTap,
        compress: compress,
        crop: crop,
      )
    ];
    if (takePhoto) {
      items.add(PickerMenuItem.imageTake(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        onTap: onTap,
        compress: compress,
        crop: crop,
        resolution: resolution,
      ));
    }
    return pick(
      context,
      items: items,
      maxCount: maxCount,
      showSheetOnlyOne: showSheetOnlyOne,
    );
  }

  //视频选择方法
  Future<JPickerResult?> pickVideo(
    BuildContext context, {
    int maxCount = 1,
    bool showSheetOnlyOne = false,
    bool recordVideo = true,
    Duration? maxRecordDuration,
    CameraResolution? resolution,
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseVideoProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
    //视频处理部分参数
    bool compress = true,
  }) {
    List<PickerMenuItem> items = [
      PickerMenuItem.video(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        allowedExtensions: allowedExtensions,
        onTap: onTap,
        compress: compress,
      )
    ];
    if (recordVideo) {
      items.add(PickerMenuItem.videoRecord(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        onTap: onTap,
        compress: compress,
        maxRecordDuration: maxRecordDuration,
        resolution: resolution,
      ));
    }
    return pick(
      context,
      items: items,
      maxCount: maxCount,
      showSheetOnlyOne: showSheetOnlyOne,
    );
  }

  //音频选择方法
  Future<JPickerResult?> pickAudio(
    BuildContext context, {
    int maxCount = 1,
    bool showSheetOnlyOne = false,
    bool recordAudio = true,
    Duration? maxRecordDuration,
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    List<String>? allowedExtensions,
    VoidCallback? onTap,
  }) {
    List<PickerMenuItem> items = [
      PickerMenuItem.audio(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        allowedExtensions: allowedExtensions,
        onTap: onTap,
      )
    ];
    if (recordAudio) {
      items.add(PickerMenuItem.audioRecord(
        title: title,
        subTitle: subTitle,
        leading: leading,
        process: process,
        onTap: onTap,
        maxRecordDuration: maxRecordDuration,
      ));
    }
    return pick(
      context,
      items: items,
      maxCount: maxCount,
      showSheetOnlyOne: showSheetOnlyOne,
    );
  }

  //自定义文件选择方法
  Future<JPickerResult?> pickCustom(
    BuildContext context, {
    int maxCount = 1,
    bool showSheetOnlyOne = false,
    //基础参数
    Widget? title,
    Widget? subTitle,
    Widget? leading,
    List<BaseAudioProcess>? process,
    required List<String> allowedExtensions,
    VoidCallback? onTap,
  }) {
    return pick(
      context,
      items: [
        PickerMenuItem.custom(
          title: title,
          subTitle: subTitle,
          leading: leading,
          process: process,
          allowedExtensions: allowedExtensions,
          onTap: onTap,
        )
      ],
      maxCount: maxCount,
      showSheetOnlyOne: showSheetOnlyOne,
    );
  }

  //执行pick方法
  Future<JPickerResult?> _doPick(
    BuildContext context,
    PickerMenuItem item,
    int maxCount,
  ) async {
    item.onTap?.call();
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
      files = await _processFiles(files, item);
      return JPickerResult(files: files);
    }
  }

  //处理文件
  Future<List<JFileInfo>> _processFiles(
    List<JFileInfo> files,
    PickerMenuItem item,
  ) async {
    var process = item.process;
    if (null == process || process.isEmpty) return files;
    List<JFileInfo> tempList = [];
    for (var f in files) {
      for (var p in process) {
        tempList.add(await p.process(f));
      }
    }
    return tempList;
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
