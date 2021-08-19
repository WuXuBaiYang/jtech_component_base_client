import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频录制组件
* @author wuxubaiyang
* @Time 2021/8/7 1:27
*/
class JAudioRecord extends BaseStatefulWidgetMultiply {
  //控制器
  final JAudioRecordController controller;

  //配置对象
  final AudioRecordConfig config;

  JAudioRecord({
    required BaseJAudioRecordState currentState,
    required this.controller,
    required this.config,
  }) : super(currentState: currentState);

  //构建完整版录音器组件
  static JAudioRecord full({
    //基本录音器参数
    JAudioRecordController? controller,
    AudioRecordConfig? config,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    //完整版录音器参数
    FullAudioRecordConfig? fullConfig,
    Widget? title,
    EdgeInsetsGeometry? titlePadding,
  }) {
    return JAudioRecord(
      controller: controller ?? JAudioRecordController(),
      config: (config ?? AudioRecordConfig()).copyWith(
        margin: margin,
        padding: padding,
        elevation: elevation,
      ),
      currentState: JAudioRecordFullState(
        config: (fullConfig ?? FullAudioRecordConfig()).copyWith(
          title: title,
          titlePadding: titlePadding,
        ),
      ),
    );
  }

  //构建简易版录音器组件
  static JAudioRecord simple({
    //基本录音器参数
    JAudioRecordController? controller,
    AudioRecordConfig? config,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Duration? maxDuration,
  }) {
    return JAudioRecord(
      controller: controller ?? JAudioRecordController(),
      currentState: JAudioRecordSimpleState(),
      config: (config ?? AudioRecordConfig()).copyWith(
        margin: margin,
        padding: padding ?? EdgeInsets.all(8),
        elevation: elevation,
      ),
    );
  }

  //获取音频文件存储路径
  Future<String> getFilePath() async {
    var fileName = "${jTools.getDateSign()}.m4a"; //暂时用固定后缀
    var dirPath = config.savePath ?? await jFile.getAudioCacheDirPath();
    return join(dirPath, fileName);
  }
}

/*
* 音频录制组件状态基类
* @author jtechjh
* @Time 2021/8/13 10:53 上午
*/
abstract class BaseJAudioRecordState extends BaseState<JAudioRecord> {
  @override
  Widget build(BuildContext context) {
    return JCard.single(
      margin: widget.config.margin,
      padding: widget.config.padding,
      elevation: widget.config.elevation,
      color: widget.config.backgroundColor,
      child: buildAudioContent(context),
    );
  }

  //构建音频录音器容器
  Widget buildAudioContent(BuildContext context);

  //构建进度相关组件
  Widget buildRecordProgress() {
    return StreamBuilder<AudioProgress>(
      stream: widget.controller.onProgress,
      initialData: AudioProgress.zero(),
      builder: (context, snap) {
        var curr = snap.data!.position;
        var max = snap.data!.duration;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 12),
            buildProgressBar(curr, max),
            buildProgressLabel(curr, max)
          ],
        );
      },
    );
  }

  //创建进度条
  Widget buildProgressBar(Duration curr, Duration max) {
    bool isStopped = widget.controller.isStopped;
    var color = isStopped ? Colors.grey : null;
    var ratio = curr.divide(max);
    return RotatedBox(
      quarterTurns: 90,
      child: LinearProgressIndicator(
        value: 1 - ratio,
        color: color,
        backgroundColor: color,
      ),
    );
  }

  //创建进度文字提示
  Widget buildProgressLabel(
    Duration curr,
    Duration max, {
    TextStyle? textStyle,
  }) {
    var fCurr = jDurationFormat.formatMMSS(curr);
    var fMax = jDurationFormat.formatMMSS(max);
    return Text(
      "$fCurr/$fMax",
      style: textStyle ?? TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  //构建播放按钮
  Widget buildRecordButton(
    BuildContext context, {
    required AudioState state,
    double iconSize = 60,
    Color? iconColor,
  }) {
    return IconButton(
      icon: Icon(state == AudioState.progressing
          ? Icons.pause_circle_outline_rounded
          : Icons.play_circle_outline_rounded),
      iconSize: iconSize,
      color: iconColor,
      onPressed: () async {
        if (state == AudioState.stopped) {
          if (widget.controller.hasMaxCount) {
            return jToast.showShortToastTxt(context, text: "已达到最大数量限制");
          }
          await widget.controller.start(
            context,
            path: await widget.getFilePath(),
          );
        } else if (state == AudioState.progressing) {
          await widget.controller.pause();
        } else if (state == AudioState.pause) {
          await widget.controller.resume();
        }
      },
    );
  }

  //构建录音文件列表按钮
  Widget buildRecordListButton(BuildContext context) {
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: widget.controller.audioListListenable,
      builder: (context, value, child) {
        return Visibility(
          visible: value.isNotEmpty,
          child: value.length == 1
              ? IconButton(
                  icon: Icon(Icons.history_rounded),
                  onPressed: () =>
                      _showRecordPlayerDialog(context, value.first),
                )
              : PopupMenuButton<JFileInfo>(
                  icon: Icon(Icons.history_rounded),
                  itemBuilder: (context) {
                    var files = widget.controller.audioFiles;
                    return List.generate(
                      files.length,
                      (index) {
                        var item = files[index];
                        return PopupMenuItem(
                          child: Text(item.name ?? ""),
                          value: item,
                        );
                      },
                    );
                  },
                  onSelected: (value) =>
                      _showRecordPlayerDialog(context, value),
                ),
        );
      },
    );
  }

  //展示录音弹窗
  void _showRecordPlayerDialog(BuildContext context, JFileInfo fileInfo) =>
      jDialog.showCustomDialog(
        context,
        config: DialogConfig(
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.all(15),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fileInfo.name ?? ""),
              Row(
                children: [
                  Expanded(
                      child: JAudioPlayer.simple(
                    dataSource: DataSource.file(fileInfo.file),
                    elevation: 0,
                  )),
                  IconButton(
                    icon: Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      widget.controller.removeRecordFile(fileInfo);
                      jRouter.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    //销毁控制器
    widget.controller.dispose();
  }
}
