import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/tools/file_picker/file_info.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';
import 'package:jtech_common_library/widgets/image/clip.dart';
import 'package:jtech_common_library/widgets/image/config.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* 视频录制页面
* @author jtechjh
* @Time 2021/8/3 5:03 下午
*/
@protected
class RecordVideoPage extends BaseCameraPage {
  //记录当前已生成文件集合
  final ListValueChangeNotifier<JFileInfo> fileList;

  //当前所选下标
  final ValueChangeNotifier<int> currentIndex;

  //是否正在录制中
  final ValueChangeNotifier<bool> recording;

  //视频预览组件控制器
  final PageController pageController;

  //最大可录制数量
  final int maxCount;

  //最大可录制时长
  final Duration maxRecordDuration;

  RecordVideoPage({
    bool front = false,
    CameraResolution? resolution,
    this.maxCount = 1,
    this.maxRecordDuration = const Duration(seconds: 60),
  })  : this.fileList = ListValueChangeNotifier.empty(),
        this.currentIndex = ValueChangeNotifier(0),
        this.pageController = PageController(),
        this.recording = ValueChangeNotifier(false),
        assert(maxCount > 0, "最大数量不可小于等于0"),
        super(
          front: front,
          resolution: resolution,
        );

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        buildCameraPreview(context),
        ValueListenableBuilder<bool>(
          valueListenable: recording,
          builder: (context, value, child) =>
              value ? EmptyBox() : _buildPreview(),
        ),
        Column(
          children: [
            Expanded(child: EmptyBox(), flex: 2),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: recording,
                    builder: (context, value, child) => Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: value
                              ? _buildRecordProgress()
                              : _buildPreviewIndicator(),
                        ),
                        Expanded(flex: 3, child: _buildCameraActions(value)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }

  //判断是否达到最大数量限制
  bool get hasMaxCount => maxCount <= fileList.length;

  //操作控制器跳转到某页
  void animToPage(int page) => pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 350),
        curve: Curves.ease,
      );

  //构建预览组件
  Widget _buildPreview() {
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: fileList,
      builder: (context, value, child) {
        var offset = (hasMaxCount || value.isEmpty) ? 0 : 1;
        return PageView(
          controller: pageController,
          onPageChanged: (index) => currentIndex.setValue(index),
          children: List.generate(value.length + offset, (index) {
            if (offset > 0 && index == 0) return EmptyBox();
            var item = value[index - offset];
            return Container(
              color: Colors.black,
              child: JImage.file(
                item.file,
                config: ImageConfig(
                  alignment: Alignment.topCenter,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  //构建预览组件的指示器
  Widget _buildPreviewIndicator() {
    var borderRadius = BorderRadius.circular(4);
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        var offset = (hasMaxCount || fileList.isEmpty) ? 0 : 1;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(fileList.length + offset, (index) {
              var selected = value == index;
              var operateIcon = offset > 0 && index == 0;
              var child;
              if (operateIcon) {
                child = Icon(
                  Icons.camera,
                  color: Colors.white,
                );
              } else {
                var item = fileList.getItem(index - offset);
                child = JImage.file(
                  item!.file,
                  config: ImageConfig(
                    clip: ImageClipRRect(
                      borderRadius: borderRadius,
                    ),
                  ),
                  fit: BoxFit.cover,
                );
              }
              return IconButton(
                icon: Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    shape: operateIcon
                        ? CircleBorder()
                        : RoundedRectangleBorder(borderRadius: borderRadius),
                    color: selected ? Colors.blue : null,
                  ),
                  child: child,
                ),
                onPressed: () => animToPage(index),
              );
            }),
          ),
        );
      },
    );
  }

  //构建录制进度组件
  Widget _buildRecordProgress() {
    return EmptyBox();
  }

  //构建摄像头操作部分
  Widget _buildCameraActions(bool isRecording) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        var canOperate = (hasMaxCount ? 0 : 1) > 0 && value == 0;
        var iconData = isRecording
            ? Icons.crop_square_rounded
            : (canOperate ? Icons.camera : Icons.done);
        return Row(
          children: [
            Expanded(child: EmptyBox()),
            FloatingActionButton(
              backgroundColor: isRecording ? Colors.white : null,
              child: Icon(
                iconData,
                color: isRecording ? Colors.redAccent : null,
              ),
              onPressed: () {
                if (canOperate) {
                  Feedback.forTap(context);
                  return _startRecordVideo();
                }
                if (isRecording) {
                  Feedback.forTap(context);
                  return _stopRecordVideo();
                }
                jBase.router.pop(fileList.value);
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: isRecording
                    ? IconButton(
                        splashRadius: 25,
                        icon: Icon(Icons.pause_circle_outline_rounded),
                        color: Colors.white,
                        onPressed: () async {
                          ///
                          await controller?.pauseVideoRecording();
                        },
                      )
                    : (canOperate
                        ? EmptyBox()
                        : IconButton(
                            splashRadius: 25,
                            icon: Icon(Icons.delete_outline),
                            color: Colors.white,
                            onPressed: () {
                              if (!currentIndex.setValue(
                                  value - (value >= fileList.length ? 1 : 0))) {
                                currentIndex.update(true);
                              }
                              fileList
                                  .removeValueAt(value - (hasMaxCount ? 0 : 1));
                            },
                          )),
              ),
            ),
          ],
        );
      },
    );
  }

  //开始录制视频
  void _startRecordVideo() async {
    await controller?.prepareForVideoRecording();
    await controller?.startVideoRecording();
    recording.setValue(true);
  }

  //停止录制视频
  void _stopRecordVideo() async {
    recording.setValue(false);
  }
}

/*
* 视频录制状态管理
* @author jtechjh
* @Time 2021/8/3 5:36 下午
*/
enum RecordState {
  none,
  prepare,
  recording,
  pause,
}

/*
* 扩展录制状态枚举
* @author jtechjh
* @Time 2021/8/3 5:37 下午
*/
extension RecordStateExtension on RecordState {
  //判断是否暂停中
  bool get isPause => this == RecordState.pause;

  //判断是否正在录制
  bool get isRecording => this == RecordState.recording;

  //判断是否正在准备
  bool get isPrepare => this == RecordState.prepare;
}
