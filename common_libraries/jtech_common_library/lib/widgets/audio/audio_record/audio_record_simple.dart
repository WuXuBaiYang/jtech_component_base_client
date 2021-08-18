import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 简易版音频播放器组件状态
* @author jtechjh
* @Time 2021/8/17 10:17 上午
*/
class JAudioRecordSimpleState extends BaseJAudioRecordState {
  @override
  Widget buildAudioContent(context) {
    return Row(
      children: [
        _buildRecordOptions(context),
        Expanded(child: buildRecordProgress()),
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
                onPressed: () => widget.controller.stop(),
              ),
            )
          ],
        );
      },
    );
  }
}
