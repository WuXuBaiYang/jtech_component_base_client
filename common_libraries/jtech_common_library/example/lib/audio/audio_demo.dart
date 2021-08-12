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
  //音频播放器demo地址
  final String audioSourceUrl =
      "https://luan.xyz/files/audio/nasa_on_a_mission.mp3";

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "音频播放器/录音器",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JAudioPlayer.net(
            audioSourceUrl,
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
