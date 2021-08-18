import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 简易版音频播放器组件状态
* @author jtechjh
* @Time 2021/8/17 10:17 上午
*/
class JAudioRecordSimpleState extends BaseJAudioRecordState {
  //录音时间
  final ValueChangeNotifier<Duration> recordDuration;

  JAudioRecordSimpleState()
      : this.recordDuration = ValueChangeNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    //监听状态变化
    widget.controller.addListener(() {
      if (widget.controller.isRecording) {
        _startTimer();
      } else {
        _cancelTimer();
        if (widget.controller.isStopped) {
          recordDuration.setValue(Duration.zero);
        }
      }
    });
  }

  @override
  Widget buildAudioContent(context) {
    return Row(
      children: [
        _buildRecordOptions(context),
        Expanded(child: _buildRecordProgress()),
        buildRecordListButton(context),
      ],
    );
  }

  //构建录音器操作按钮部分
  Widget _buildRecordOptions(BuildContext context) {
    return ValueListenableBuilder<AudioState>(
      valueListenable: widget.controller.audioStateListenable,
      builder: (context, value, child) {
        return Row(
          children: [
            buildRecordButton(
              context,
              state: value,
              iconSize: 35,
            ),
            Visibility(
              visible: value != AudioState.stopped,
              child: IconButton(
                icon: Icon(Icons.stop),
                onPressed: () => widget.controller.stopRecord(),
              ),
            )
          ],
        );
      },
    );
  }

  //构建进度相关组件
  Widget _buildRecordProgress() {
    return ValueListenableBuilder<Duration>(
      valueListenable: recordDuration,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 12),
            buildProgressBar(value),
            buildProgressLabel(
              value,
              textStyle: TextStyle(fontSize: 10),
            )
          ],
        );
      },
    );
  }

  //记录计时器id
  String timerKey = "";

  //启动计时器
  void _startTimer() {
    timerKey = jTimer.countdown(
      maxDuration: widget.config.maxDuration.subtract(recordDuration.value),
      callback: (remaining, passTime) => recordDuration.setValue(passTime),
      onFinish: () => widget.controller.stopRecord(),
    );
  }

  //取消计时器
  void _cancelTimer() => jTimer.cancel(timerKey);

  @override
  void dispose() {
    super.dispose();
    //销毁定时器
    _cancelTimer();
  }
}
