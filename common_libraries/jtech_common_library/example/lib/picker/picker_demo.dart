import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 附件选择器
* @author jtechjh
* @Time 2021/8/19 9:38 上午
*/
class FilePickerDemo extends BaseStatelessPage {
  //文件选择器方法表
  final Map<String, Function> pickerMap = {
    "全部方法选择": (BuildContext context) async {
      var result = await jFilePicker.pick(
        context,
        items: [
          PickerMenuItem.image(),
          PickerMenuItem.imageTake(),
          PickerMenuItem.video(),
          PickerMenuItem.videoRecord(),
          PickerMenuItem.audio(),
          PickerMenuItem.audioRecord(),
          PickerMenuItem.custom(allowedExtensions: [".txt"]),
        ],
        maxCount: 3,
      );
      jToast.showShortToastTxt(context,
          text: "已选择 ${null != result ? result.length : 0} 个文件");
    },
    "图片选择方法": (BuildContext context) async {
      var result = await jFilePicker.pickImage(
        context,
        maxCount: 3,
      );
      jToast.showShortToastTxt(context,
          text: "已选择 ${null != result ? result.length : 0} 个文件");
    },
    "音频选择方法": (BuildContext context) async {
      var result = await jFilePicker.pickAudio(
        context,
        maxCount: 3,
      );
      jToast.showShortToastTxt(context,
          text: "已选择 ${null != result ? result.length : 0} 个文件");
    },
    "视频直接选择方法(不弹层)": (BuildContext context) async {
      var result = await jFilePicker.pickVideo(
        context,
        maxCount: 3,
        showSheetOnlyOne: false,
        recordVideo: false,
      );
      jToast.showShortToastTxt(context,
          text: "已选择 ${null != result ? result.length : 0} 个文件");
    },
    "自定义文件选择方法(不弹层)": (BuildContext context) async {
      var result = await jFilePicker.pickCustom(
        context,
        maxCount: 3,
        allowedExtensions: ["txt"],
      );
      jToast.showShortToastTxt(context,
          text: "已选择 ${null != result ? result.length : 0} 个文件");
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "附件选择器",
      body: JListView.def<String>(
        controller: JListViewController(dataList: pickerMap.keys.toList()),
        itemBuilder: (_, item, __) {
          return ListTile(
            title: Text(item),
            onTap: () => pickerMap[item]?.call(context),
          );
        },
      ),
    );
  }
}
