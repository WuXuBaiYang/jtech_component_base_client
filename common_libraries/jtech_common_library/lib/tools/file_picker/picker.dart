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
    //当只有一个选项的时候，是否显示sheet
    bool showSheetOnlyOne = false,
  }) async {
    if (items.isEmpty) return null;
    if (showSheetOnlyOne && items.length == 1) {
      return _doPick(items.first);
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
              onTap: () => _doPick(item),
            );
          },
        ),
      ),
    );
  }

  //执行pick方法
  Future<JPickerResult?> _doPick(PickerMenuItem item) async {
    item.onPress?.call();
    List<JFileInfo>? files;
    ///待完成
    switch (item.type) {
      case PickerType.image:
        break;
      case PickerType.imageTake:
        break;
      case PickerType.video:
        break;
      case PickerType.videoRecord:
        break;
      case PickerType.audio:
        break;
      case PickerType.audioRecord:
        break;
      case PickerType.custom:
        break;
    }
    if (null != files && files.isNotEmpty) {
      return JPickerResult(files: files);
    }
  }
}

//单例调用
final jFilePicker = JFilePicker();
