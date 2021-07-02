import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/event/base_event_model.dart';

//注册事件的消息回调
typedef OnEventListen = void Function<T extends BaseEventModel>(T event);

/*
* 消息总线管理
* @author wuxubaiyang
* @Time 2021/6/30 下午5:28
*/
@protected
class JEvent {
  static final JEvent _instance = JEvent._internal();

  factory JEvent() => _instance;

  JEvent._internal();

  //消息总线对象
  final eventBus = EventBus(sync: true);

  //注册事件
  void on<T extends BaseEventModel>({required OnEventListen listen}) {
    eventBus.on<T>().listen((event) {
      listen(event);
    });
  }

  //注册单次事件
  Future<T> onOnce<T extends BaseEventModel>() async {
    return eventBus.on<T>().first;
  }

  //发送事件
  void send<T extends BaseEventModel>(T event) async {
    eventBus.fire(event);
  }
}

//单例调用
final jEvent = JEvent();
