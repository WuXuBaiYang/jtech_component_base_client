import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 默认音频播放器组件状态
* @author jtechjh
* @Time 2021/8/17 9:08 上午
*/
class JAudioPlayerSimpleState extends BaseJAudioPlayerState {
  @override
  Widget buildAudioContent(context) {
    return Row(
      children: [
        _buildPlayOptions(),
        Expanded(child: buildPlayerProgress()),
      ],
    );
  }

  //构建播放器操作按钮部分
  Widget _buildPlayOptions() {
    return ValueListenableBuilder<AudioState>(
      valueListenable: widget.controller.audioStateListenable,
      builder: (context, value, child) {
        return buildPlayButton(value, iconSize: 35);
      },
    );
  }
}
