import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  //完全版控制器
  final JAudioPlayerController playerControllerFull = JAudioPlayerController();

  //简易版控制器
  final JAudioPlayerController playerControllerSimple =
      JAudioPlayerController();

  //完全版录音器控制器
  final JAudioRecordController recordControllerFull = JAudioRecordController();

  //简易版录音器控制器
  final JAudioRecordController recordControllerSimple =
      JAudioRecordController();

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
                    playerControllerFull.seekToPlay(Duration(seconds: 50));
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("2倍速播放"),
                  onTap: () {
                    playerControllerFull.setSpeed(2);
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("静音"),
                  onTap: () {
                    playerControllerFull.setVolume(0);
                    jBase.router.pop();
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text("切换播放器"),
                  onTap: () {
                    playerControllerFull.speakerToggle();
                    jBase.router.pop();
                  },
                ),
              ),
            ];
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35),
            Text("完整版音频播放器"),
            SizedBox(height: 35),
            JAudioPlayer.full(
              dataSource: DataSource.net(audioSourceUrl),
              controller: playerControllerFull,
              fullConfig: FullAudioPlayerConfig(
                title: Text("这里是播放器标题"),
              ),
            ),
            SizedBox(height: 35),
            Text("简易版音频播放器"),
            SizedBox(height: 35),
            JAudioPlayer.simple(
              dataSource: DataSource.net(audioSourceUrl),
              controller: playerControllerSimple,
            ),
            SizedBox(height: 35),
            Text("完全版录音器"),
            SizedBox(height: 35),
            JAudioRecord.full(
              controller: recordControllerFull,
              fullConfig: FullAudioRecordConfig(
                title: Text("这里是录音器标题"),
              ),
            ),
            SizedBox(height: 35),
            Text("简易版录音器"),
            SizedBox(height: 35),
            JAudioRecord.simple(
              controller: recordControllerSimple,
            ),
          ],
        ),
      ),
    );
  }
}
