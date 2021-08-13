import 'dart:async';
import 'model.dart';

/*
* 消息总线管理
* @author wuxubaiyang
* @Time 2021/6/30 下午5:28
*/
class JEvent {
  static final JEvent _instance = JEvent._internal();

  factory JEvent() => _instance;

  JEvent._internal()
      : this._streamController = StreamController.broadcast(sync: false);

  //流控制器
  StreamController _streamController;

  //初始化方法
  Future init() async {}

  //注册事件
  Stream<T> on<T extends EventModel>() {
    if (T == EventModel) {
      return _streamController.stream as Stream<T>;
    } else {
      return _streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  //发送事件
  void send<T extends EventModel>(T event) => _streamController.add(event);

  //销毁消息总线
  void destroy() => _streamController.close();
}

//单例调用
final jEvent = JEvent();
