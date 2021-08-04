import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/video_player/config.dart';

/*
* 视频播放器控制器
* @author jtechjh
* @Time 2021/8/4 10:36 上午
*/
class JVideoPlayerController extends BaseController {
  //播放器状态监听
  final ValueChangeNotifier<PlayerState> _playerState;

  JVideoPlayerController()
      : this._playerState = ValueChangeNotifier(PlayerState.none);

  //获取播放器状态监听
  ValueListenable<PlayerState> get playerListenable => _playerState;

  //更新播放器状态
  void updateState(PlayerState state) => _playerState.setValue(state);
}
