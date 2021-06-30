import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/event/base_event_model.dart';

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
  final eventBus = EventBus();

  //注册事件
  Future<void> on<T extends BaseEventModel>() async {
    eventBus.on<T>();
  }
  //发送事件
  Future<void> send()async{

  }
}

//单例调用
final jEvent = JEvent();
