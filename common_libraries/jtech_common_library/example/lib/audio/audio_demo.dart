import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 音频播放器/录音器组件演示
* @author jtechjh
* @Time 2021/8/10 10:55 上午
*/
class AudioDemo extends BaseStatelessPage {
  //音频播放器demo地址
  final String audioSourceUrl =
      "https://luan.xyz/files/audio/nasa_on_a_mission.mp3";

  //播放器控制器
  final JAudioPlayerController playerController = JAudioPlayerController();

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "音频播放器/录音器",
      appBarActions: [
        PopupMenuButton(
          child: Center(child: Text("播放器")),
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: ListTile(
                  title: Text("进度定位到50秒"),
                  onTap: () {
                    playerController.seekToPlay(Duration(seconds: 50));
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("2倍速播放"),
                  onTap: () {
                    playerController.setSpeed(2);
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("静音"),
                  onTap: () {
                    playerController.setVolume(0);
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("切换播放器"),
                  onTap: () {
                    playerController.speakerToggle();
                    jBase.router.pop();
                  },
                ),
              ),
            ];
          },
        ),
      ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JAudioPlayer.net(
            audioSourceUrl,
            controller: playerController,
            config: AudioPlayerConfig(
              title: Text("这里是播放器标题"),
            ),
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
