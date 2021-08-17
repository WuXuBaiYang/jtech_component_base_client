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
  Widget buildAudioContent() {
    return Row(
      children: [
        _buildPlayOptions(),
        Expanded(child: _buildProgressSlider()),
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

  //构建播放器进度部分
  Widget _buildProgressSlider() {
    return StreamBuilder<PlayProgress>(
      initialData: PlayProgress.zero(),
      stream: widget.controller.onProgress,
      builder: (context, snap) {
        if (!snap.hasData) return EmptyBox();
        var max = snap.data!.duration;
        return Row(
          children: [
            Expanded(child: buildProgressSlider(snap.data!.ratio, max)),
            buildProgressLabel(snap.data!.position, max,
                textStyle: TextStyle(fontSize: 10)),
          ],
        );
      },
    );
  }
}
