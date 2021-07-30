import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/popups/sheet/config.dart';
import 'package:jtech_common_library/tools/file_picker/file_info.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* 拍照页面
* @author jtechjh
* @Time 2021/7/30 2:30 下午
*/
@protected
class TakePhotoPage extends BaseCameraPage {
  TakePhotoPage({
    bool front = false,
    CameraResolution? resolution,
  }) : super(
          front: front,
          resolution: resolution,
        );

  @override
  Widget buildCameraContent(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(55),
        child: FloatingActionButton(
          child: Icon(Icons.camera_rounded),
          onPressed: () async {
            var result = await controller?.takePicture();
            result = await _showPictureConfirm(context, result);
            if (null != result) {
              jBase.router.pop(JFileInfo(
                path: result.path,
                name: result.name,
                length: await result.length(),
                mimeType: result.mimeType,
              ));
            }
          },
        ),
      ),
    );
  }

  //展示拍照确认界面
  Future<XFile?> _showPictureConfirm(
      BuildContext context, XFile? result) async {
    if (null == result) return result;
    return jCommon.popups.sheet.showFullBottomSheet<XFile>(
      context,
      cancelItem: null,
      config: SheetConfig(
        contentPadding: EdgeInsets.zero,
        sheetColor: Colors.black,
      ),
      content: Column(
        children: [
          JImage.file(File(result.path)),
          SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                  child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () => jBase.router.pop(),
              )),
              Expanded(
                  child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.done),
                onPressed: () => jBase.router.pop(result),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
