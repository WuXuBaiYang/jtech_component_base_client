import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';

/*
* 视频录制页面
* @author jtechjh
* @Time 2021/7/30 2:30 下午
*/
@protected
class RecordVideoPage extends BaseCameraPage {
  RecordVideoPage({
    bool front = false,
    CameraResolution? resolution,
  }) : super(
          front: front,
          resolution: resolution,
        );

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    throw UnimplementedError();
  }

}
