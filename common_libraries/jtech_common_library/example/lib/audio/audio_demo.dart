import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/audio_player/audio_player.dart';
import 'package:jtech_common_library/widgets/audio_record/audio_record.dart';

/*
* 音频播放器/录音器组件演示
* @author jtechjh
* @Time 2021/8/10 10:55 上午
*/
class AudioDemo extends BasePage {
  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "音频播放器/录音器",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JAudioPlayer.net(
            "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3",
          ),
          SizedBox(height: 35),
          JAudioRecord(
            onRecordFinish: (String path) {
              jCommon.popups.snack
                  .showSnackInTime(context, text: "录音存储路径：$path");
            },
          ),
        ],
      ),
    );
  }
}
