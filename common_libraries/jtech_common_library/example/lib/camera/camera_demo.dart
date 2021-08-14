import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 摄像头相关demo
* @author wuxubaiyang
* @Time 2021/8/15 0:22
*/
class CameraDemo extends BaseStatelessPage {
  //列表组件
  final Map<String, Function> listviewMap = {
    "拍照返回": () async {
      var result = await CameraPage.takePhoto(
        maxCount: 3,
        front: false,
        resolution: CameraResolution.medium,
      );
      print(result);
    },
    "视频录制返回": () async {
      var result = await CameraPage.recordVideo(
        maxCount: 3,
        front: false,
        resolution: CameraResolution.medium,
        maxRecordDuration: Duration(seconds: 5),
      );
      print(result);
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "摄像头相关demo",
      body: JListView.def<String>(
        dividerBuilder: (_, index) => Divider(),
        itemBuilder: (_, item, index) {
          return ListTile(
            title: Text(item),
            onTap: () => listviewMap[item]?.call(),
          );
        },
        controller: JListViewController(
          dataList: listviewMap.keys.toList(),
        ),
      ),
    );
  }
}
