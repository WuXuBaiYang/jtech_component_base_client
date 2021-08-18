import 'package:jtech_common_library/jcommon.dart';
/*
* 进度对象
* @author jtechjh
* @Time 2021/8/9 5:42 下午
*/
class AudioProgress {
  //音频总时长
  final Duration duration;

  //当前播放时长
  final Duration position;

  //判断总播放时长是否为空
  bool get isEmpty => duration.inMicroseconds == 0;

  //获取播放进度
  double get ratio => position.divide(duration);

  AudioProgress.zero()
      : this.duration = Duration.zero,
        this.position = Duration.zero;

  AudioProgress.from({
    required this.duration,
    required this.position,
  });
}

/*
* 音频状态管理
* @author jtechjh
* @Time 2021/8/10 1:19 下午
*/
enum AudioState {
  progressing,
  stopped,
  pause,
}
