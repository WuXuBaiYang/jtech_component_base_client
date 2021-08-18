import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 完整版音频播放器组件状态
* @author jtechjh
* @Time 2021/8/17 10:17 上午
*/
class JAudioRecordFullState extends BaseJAudioRecordState {
  //配置对象
  final FullAudioRecordConfig config;

  JAudioRecordFullState({
    required this.config,
  });

  @override
  Widget buildAudioContent(context) {
    return Column(
      children: [
        _buildTitleContent(context),
        buildRecordProgress(),
        _buildRecordOptions(),
      ],
    );
  }

  //构建标题部分容器
  Widget _buildTitleContent(BuildContext context) {
    return Container(
      padding: config.titlePadding,
      child: Row(
        children: [
          config.title ?? EmptyBox(),
          Expanded(child: EmptyBox()),
        ],
      ),
    );
  }

  //构建录音器操作部分
  Widget _buildRecordOptions() {
    return ValueListenableBuilder<AudioState>(
      valueListenable: widget.controller.audioStateListenable,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(child: EmptyBox()),
            buildRecordButton(
              context,
              state: value,
            ),
            Expanded(
                child: Row(
              children: [
                Visibility(
                  visible: value != AudioState.stopped,
                  child: IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () => widget.controller.stop(),
                  ),
                ),
                Expanded(child: EmptyBox()),
                buildRecordListButton(context),
              ],
            )),
          ],
        );
      },
    );
  }
}
