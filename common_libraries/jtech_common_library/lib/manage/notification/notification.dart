import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jtech_base_library/jbase.dart';

//当收到消息通知时的回调
typedef OnReceiveNotification = Future Function(
    int id, String? title, String? body, String? payload);

//当通知消息被点击触发时
typedef OnSelectNotification = Future Function(String? payload);

/*
* 本地通知管理
* @author jtechjh
* @Time 2021/8/31 11:14 上午
*/
class JNotificationManage extends BaseManage {
  static final JNotificationManage _instance = JNotificationManage._internal();

  factory JNotificationManage() => _instance;

  JNotificationManage._internal();

  //默认图标名称
  final String _defaultIconName = "ic_launcher";

  //接受通知消息回调集合
  final List<OnReceiveNotification> _receiveNotificationListeners = [];

  //通知消息点击触发回调集合
  final List<OnSelectNotification> _selectNotificationListeners = [];

  //通知推送管理
  late FlutterLocalNotificationsPlugin localNotifications;

  @override
  Future<void> init() async {
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(_defaultIconName),
        iOS: IOSInitializationSettings(
          onDidReceiveLocalNotification: _onReceiveNotification,
        ),
      ),
      onSelectNotification: _onNotificationSelect,
    );
  }

  //当接收到通知消息回调
  Future _onReceiveNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    _receiveNotificationListeners.forEach((listener) async {
      await listener(id, title, body, payload);
    });
  }

  //消息通知点击事件回调
  Future _onNotificationSelect(String? payload) async {
    _selectNotificationListeners.forEach((listener) async {
      await listener(payload);
    });
  }
}

//单例调用
final jNotificationManage = JNotificationManage();
