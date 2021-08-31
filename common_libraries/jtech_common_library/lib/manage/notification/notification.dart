import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

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
  late FlutterLocalNotificationsPlugin localNotification;

  @override
  Future<void> init() async {
    localNotification = FlutterLocalNotificationsPlugin()
      ..initialize(
        InitializationSettings(
          android: AndroidInitializationSettings(_defaultIconName),
          iOS: IOSInitializationSettings(
            onDidReceiveLocalNotification: _onReceiveNotification,
          ),
        ),
        onSelectNotification: _onNotificationSelect,
      );
  }

  //显示进度通知
  Future<void> showProgress({
    int? id,
    String? title,
    String? body,
    String? androidIcon,
    String? payload,
    required int maxProgress,
    required int progress,
    required bool indeterminate,
    NotificationConfig? config,
  }) {
    if (null == body) {
      double ratio = (progress / maxProgress.toDouble()) * 100;
      body = "$progress/$maxProgress ${ratio.toStringAsFixed(1)}%";
    }
    return show(
      config: (config ?? NotificationConfig(id: id ?? 0)).copyWith(
        id: id,
        title: title,
        body: body,
        payload: payload,
        androidConfig: AndroidNotificationConfig(
          icon: androidIcon,
          showProgress: true,
          maxProgress: maxProgress,
          progress: progress,
          indeterminate: indeterminate,
          playSound: false,
          enableLights: false,
          enableVibration: false,
          ongoing: true,
          onlyAlertOnce: false,
        ),
        iosConfig: IOSNotificationConfig(
          presentSound: false,
          presentBadge: false,
        ),
      ),
    );
  }

  //显示简易通知栏消息
  Future<void> showSimple({
    required String title,
    int? id,
    String? body,
    String? androidIcon,
    String? payload,
    bool androidAlertOnce = false,
    bool playSound = true,
    NotificationConfig? config,
  }) async {
    return show(
      config: (config ?? NotificationConfig(id: id ?? 0)).copyWith(
        title: title,
        body: body,
        payload: payload,
        androidConfig: AndroidNotificationConfig(
          icon: androidIcon,
          onlyAlertOnce: androidAlertOnce,
          playSound: playSound,
        ),
        iosConfig: IOSNotificationConfig(
          presentSound: playSound,
        ),
      ),
    );
  }

  //显示通知栏消息
  Future<void> show({
    required NotificationConfig config,
  }) async {
    //申请ios权限
    if (Platform.isIOS) {
      var result = await localNotification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      if (null != result && !result) return;
    }

    var androidConfig = config.androidConfig ?? AndroidNotificationConfig();
    var androidSpecifics = AndroidNotificationDetails(
      androidConfig.channelId ?? "${config.id}",
      androidConfig.channelName ?? "${config.id}",
      androidConfig.channelDescription ?? "${config.id}",
      channelShowBadge: androidConfig.channelShowBadge,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: null != androidConfig.when,
      when: androidConfig.when?.inMilliseconds ?? 0,
      icon: androidConfig.icon,
      playSound: androidConfig.playSound,
      enableVibration: androidConfig.enableVibration,
      groupKey: androidConfig.groupKey,
      setAsGroupSummary: androidConfig.setAsGroupSummary,
      autoCancel: androidConfig.autoCancel,
      ongoing: androidConfig.ongoing,
      onlyAlertOnce: androidConfig.onlyAlertOnce,
      enableLights: androidConfig.enableLights,
      timeoutAfter: androidConfig.timeoutAfter?.inMilliseconds,
      showProgress: androidConfig.showProgress,
      maxProgress: androidConfig.maxProgress,
      progress: androidConfig.progress,
      indeterminate: androidConfig.indeterminate,
    );
    var iosConfig = config.iosConfig ?? IOSNotificationConfig();
    var iosSpecifics = IOSNotificationDetails(
      presentAlert: iosConfig.presentAlert,
      presentBadge: iosConfig.presentBadge,
      presentSound: iosConfig.presentSound,
      sound: iosConfig.sound,
      badgeNumber: iosConfig.badgeNumber,
      subtitle: iosConfig.subtitle,
      threadIdentifier: iosConfig.threadIdentifier,
    );
    return localNotification.show(
      config.id,
      config.title,
      config.body,
      NotificationDetails(
        android: androidSpecifics,
        iOS: iosSpecifics,
      ),
      payload: config.payload,
    );
  }

  //取消通知
  Future<void> cancel(int id, {String? tag}) =>
      localNotification.cancel(id, tag: tag);

  //取消所有通知
  Future<void> cancelAll() => localNotification.cancelAll();

  //添加接受消息监听
  void addReceiveListener(OnReceiveNotification listener) =>
      _receiveNotificationListeners.add(listener);

  //添加消息选择监听
  void addSelectListener(OnSelectNotification listener) =>
      _selectNotificationListeners.add(listener);

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
