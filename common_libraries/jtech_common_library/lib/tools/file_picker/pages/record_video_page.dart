import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/tools/file_picker/file_info.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';
import 'package:jtech_common_library/widgets/image/clip.dart';
import 'package:jtech_common_library/widgets/image/config.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';
import 'package:jtech_common_library/tools/data_format.dart';
import 'package:jtech_common_library/widgets/video_player/config.dart';
import 'package:jtech_common_library/widgets/video_player/video_player.dart';

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

  //当前视频录制状态
  final ValueChangeNotifier<RecordState> recordState;

  //录制限时计数器
  final ValueChangeNotifier<Duration> recordTick;

  //录制定时器跳动频率
  final Duration timerPeriodic = Duration(seconds: 1);

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
        this.recordState = ValueChangeNotifier(RecordState.none),
        this.recordTick = ValueChangeNotifier(maxRecordDuration),
        assert(maxCount > 0, "最大数量不可小于等于0"),
        assert(
          maxRecordDuration.inSeconds >= 1 && maxRecordDuration.inMinutes <= 30,
          "录制时间范围 1秒-30分钟",
        ),
        super(
          front: front,
          resolution: resolution,
        );

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        buildCameraPreview(context),
        ValueListenableBuilder<RecordState>(
          valueListenable: recordState,
          builder: (_, value, child) {
            if (!value.isNone) return EmptyBox();
            return _buildPreview();
          },
        ),
        Column(
          children: [
            Expanded(child: EmptyBox(), flex: 2),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: ValueListenableBuilder<RecordState>(
                    valueListenable: recordState,
                    builder: (_, value, child) => Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: !value.isNone
                              ? _buildRecordProgress(value)
                              : _buildPreviewIndicator(),
                        ),
                        Expanded(
                            flex: 3,
                            child: _buildCameraActions(context, value)),
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
      builder: (_, value, child) {
        var offset = (hasMaxCount || value.isEmpty) ? 0 : 1;
        return PageView(
          controller: pageController,
          onPageChanged: (index) => currentIndex.setValue(index),
          children: List.generate(value.length + offset, (index) {
            if (offset > 0 && index == 0) return EmptyBox();
            var item = value[index - offset];
            return Container(
              color: Colors.black,
              child: JVideoPlayer.file(
                file: item.file,
                autoPlay: true,
                config: VideoPlayerConfig(
                  align: Alignment.topCenter,
                  initialBuilder: (_) => EmptyBox(),
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  //指示器子项圆角
  final indicatorBorderRadius = BorderRadius.circular(4);

  //构建预览组件的指示器
  Widget _buildPreviewIndicator() {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (_, value, child) {
        var offset = (hasMaxCount || fileList.isEmpty) ? 0 : 1;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(fileList.length + offset, (index) {
              var selected = value == index;
              if (offset > 0 && index == 0) {
                return _buildPreviewIndicatorItem(
                  selected: selected,
                  child: Icon(Icons.camera, color: Colors.white),
                  shape: CircleBorder(),
                  index: index,
                );
              }
              var item = fileList.getItem(index - offset);
              return FutureBuilder<File>(
                future: item!.getVideoThumbnail(),
                builder: (_, snap) {
                  if (!snap.hasData) return EmptyBox();
                  return _buildPreviewIndicatorItem(
                    selected: selected,
                    child: JImage.file(
                      snap.data!,
                      config: ImageConfig(
                        clip: ImageClipRRect(
                          borderRadius: indicatorBorderRadius,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: indicatorBorderRadius),
                    index: index,
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }

  //构建预览指示器子项结构
  Widget _buildPreviewIndicatorItem({
    required Widget child,
    required int index,
    ShapeBorder shape = const RoundedRectangleBorder(),
    bool selected = false,
  }) {
    return IconButton(
      icon: Container(
        height: 35,
        width: 35,
        padding: EdgeInsets.all(4),
        decoration: ShapeDecoration(
          shape: shape,
          color: selected ? Colors.blue : null,
        ),
        child: child,
      ),
      onPressed: () => animToPage(index),
    );
  }

  //构建录制进度组件
  Widget _buildRecordProgress(RecordState state) {
    return ValueListenableBuilder<Duration>(
      valueListenable: recordTick,
      builder: (_, value, child) {
        var progress = !value.equal(maxRecordDuration)
            ? value.divide(maxRecordDuration)
            : 1.0;
        return Column(
          children: [
            RotatedBox(
              quarterTurns: 90,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                value: progress,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Container(
                      color: Colors.redAccent,
                      width: 13,
                      height: 13,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "${jCommon.tools.durationFormat.formatFull(value)}/${jCommon.tools.durationFormat.formatFull(maxRecordDuration)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //构建摄像头操作部分
  Widget _buildCameraActions(BuildContext context, RecordState state) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (_, value, child) {
        var canOperate = (hasMaxCount ? 0 : 1) > 0 && value == 0;
        var isWorking = state.isRecording || state.isPause;
        return Row(
          children: [
            Expanded(child: EmptyBox()),
            FloatingActionButton(
              backgroundColor: isWorking ? Colors.white : null,
              child: Icon(
                state.isPrepare
                    ? Icons.all_inclusive_rounded
                    : (isWorking
                        ? Icons.crop_square_rounded
                        : (canOperate ? Icons.camera : Icons.done)),
                color: isWorking ? Colors.redAccent : null,
              ),
              onPressed: () {
                if (state.isPrepare) return;
                if (isWorking) {
                  Feedback.forTap(context);
                  return _stopRecordVideo(context, state);
                }
                if (canOperate) {
                  Feedback.forTap(context);
                  return _startRecordVideo(context, state);
                }
                jBase.router.pop(fileList.value);
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: !state.isNone && !state.isPrepare
                    ? IconButton(
                        splashRadius: 25,
                        icon: Icon(
                          state.isRecording
                              ? Icons.pause_circle_outline_rounded
                              : Icons.play_circle_outline_rounded,
                        ),
                        color: Colors.white,
                        onPressed: () => state.isRecording
                            ? _pauseRecordVideo(state)
                            : _startRecordVideo(context, state),
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
  void _startRecordVideo(BuildContext context, RecordState state) async {
    try {
      cameraBusy = true;
      if (state.isNone) {
        recordState.setValue(RecordState.prepare);
        await controller?.prepareForVideoRecording();
        recordState.setValue(RecordState.recording);
        await controller?.startVideoRecording();
        recordTick.setValue(maxRecordDuration);
        _startRecordTimer(context);
      } else if (state.isPause) {
        recordState.setValue(RecordState.recording);
        await controller?.resumeVideoRecording();
        _startRecordTimer(context);
      }
    } catch (e) {
      recordState.setValue(RecordState.none);
      _cancelRecordTimer();
      cameraBusy = false;
    }
  }

  //暂停视频录制
  void _pauseRecordVideo(RecordState state) async {
    try {
      if (state.isRecording) {
        recordState.setValue(RecordState.pause);
        await controller?.pauseVideoRecording();
        _cancelRecordTimer();
      }
    } catch (e) {
      recordState.setValue(RecordState.none);
      _cancelRecordTimer();
    }
  }

  //停止录制视频
  void _stopRecordVideo(BuildContext context, RecordState state) async {
    try {
      if (state.isRecording || state.isPause) {
        jCommon.popups.dialog.showLoading(context);
        recordState.setValue(RecordState.none);
        var result = await controller?.stopVideoRecording();
        if (null == result) return null;
        cameraBusy = false;
        fileList.insertValue(0, [
          await JFileInfo.loadFromXFile(result),
        ]);
        currentIndex.update(true);
        _cancelRecordTimer();
      }
    } catch (e) {
      recordState.setValue(RecordState.none);
      _cancelRecordTimer();
    } finally {
      await jCommon.popups.dialog.hideLoadingDialog();
    }
  }

  //启动计时器
  void _startRecordTimer(BuildContext context) => jCommon.tools.timer.countdown(
        key: "${controller?.cameraId}",
        maxDuration: recordTick.value,
        tickDuration: timerPeriodic,
        callback: (remaining, passTime) => recordTick.setValue(remaining),
        onFinish: () => _stopRecordVideo(context, recordState.value),
      );

  //销毁当前计时器
  void _cancelRecordTimer() =>
      jCommon.tools.timer.cancel("${controller?.cameraId}");

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    controller?.dispose();
    //销毁定时器
    _cancelRecordTimer();
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
  //判断是否无动作
  bool get isNone => this == RecordState.none;

  //判断是否暂停中
  bool get isPause => this == RecordState.pause;

  //判断是否正在录制
  bool get isRecording => this == RecordState.recording;

  //判断是否正在准备
  bool get isPrepare => this == RecordState.prepare;
}
