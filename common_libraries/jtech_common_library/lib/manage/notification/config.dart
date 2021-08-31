import 'package:jtech_common_library/jcommon.dart';

/*
* 消息通知配置对象
* @author jtechjh
* @Time 2021/8/31 2:03 下午
*/
class NotificationConfig extends BaseConfig {
  //通知id
  int id;

  //通知标题
  String? title;

  //通知内容
  String? body;

  //装载
  String? payload;

  //android配置信息
  AndroidNotificationConfig? androidConfig;

  //ios配置信息
  IOSNotificationConfig? iosConfig;

  NotificationConfig({
    required this.id,
    this.title,
    this.body,
    this.payload,
    this.androidConfig,
    this.iosConfig,
  });

  @override
  NotificationConfig copyWith({
    int? id,
    String? title,
    String? body,
    String? payload,
    AndroidNotificationConfig? androidConfig,
    IOSNotificationConfig? iosConfig,
  }) {
    return NotificationConfig(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      androidConfig: androidConfig ?? this.androidConfig,
      iosConfig: iosConfig ?? this.iosConfig,
    );
  }
}

/*
* 安卓通知相关字段
* @author jtechjh
* @Time 2021/8/31 2:06 下午
*/
class AndroidNotificationConfig extends BaseConfig {
  //渠道id
  String? channelId;

  //渠道名称
  String? channelName;

  //渠道描述
  String? channelDescription;

  //图标
  String? icon;

  //是否播放声音
  bool playSound;

  //是否启用震动
  bool enableVibration;

  //分组key
  String? groupKey;

  //是否聚合分组信息
  bool setAsGroupSummary;

  //是否自动取消
  bool autoCancel;

  //是否常驻显示
  bool ongoing;

  //是否仅显示单次
  bool onlyAlertOnce;

  //是否启用灯光
  bool enableLights;

  //超时后取消
  Duration? timeoutAfter;

  //定时显示
  Duration? when;

  //是否显示渠道标记
  bool channelShowBadge;

  //是否显示进度条
  bool showProgress;

  //进度条最大进度
  int maxProgress;

  //进度条进度
  int progress;

  //进度条无进度状态
  bool indeterminate;

  AndroidNotificationConfig({
    this.channelId,
    this.channelName,
    this.channelDescription,
    this.channelShowBadge = false,
    this.icon,
    this.playSound = true,
    this.enableVibration = true,
    this.groupKey,
    this.setAsGroupSummary = true,
    this.autoCancel = false,
    this.ongoing = false,
    this.onlyAlertOnce = false,
    this.enableLights = true,
    this.timeoutAfter,
    this.when,
    this.showProgress = false,
    this.maxProgress = 0,
    this.progress = 0,
    this.indeterminate = true,
  });

  @override
  AndroidNotificationConfig copyWith({
    String? channelId,
    String? channelName,
    String? channelDescription,
    String? icon,
    bool? playSound,
    bool? enableVibration,
    String? groupKey,
    bool? setAsGroupSummary,
    bool? autoCancel,
    bool? ongoing,
    bool? onlyAlertOnce,
    bool? enableLights,
    Duration? timeoutAfter,
    Duration? when,
    bool? channelShowBadge,
    bool? showProgress,
    int? maxProgress,
    int? progress,
    bool? indeterminate,
  }) {
    return AndroidNotificationConfig(
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      channelDescription: channelDescription ?? this.channelDescription,
      icon: icon ?? this.icon,
      playSound: playSound ?? this.playSound,
      enableVibration: enableVibration ?? this.enableVibration,
      groupKey: groupKey ?? this.groupKey,
      setAsGroupSummary: setAsGroupSummary ?? this.setAsGroupSummary,
      autoCancel: autoCancel ?? this.autoCancel,
      ongoing: ongoing ?? this.ongoing,
      onlyAlertOnce: onlyAlertOnce ?? this.onlyAlertOnce,
      enableLights: enableLights ?? this.enableLights,
      timeoutAfter: timeoutAfter ?? this.timeoutAfter,
      when: when ?? this.when,
      channelShowBadge: channelShowBadge ?? this.channelShowBadge,
      showProgress: showProgress ?? this.showProgress,
      maxProgress: maxProgress ?? this.maxProgress,
      progress: progress ?? this.progress,
      indeterminate: indeterminate ?? this.indeterminate,
    );
  }
}

/*
* IOS通知相关字段
* @author jtechjh
* @Time 2021/8/31 2:06 下午
*/
class IOSNotificationConfig extends BaseConfig {
  //是否通知
  bool? presentAlert;

  //是否标记
  bool? presentBadge;

  //是否有声音
  bool? presentSound;

  //声音文件
  String? sound;

  //标记数字
  int? badgeNumber;

  //子标题
  String? subtitle;

  //线程标识
  String? threadIdentifier;

  IOSNotificationConfig({
    this.presentAlert,
    this.presentBadge,
    this.presentSound,
    this.sound,
    this.badgeNumber,
    this.subtitle,
    this.threadIdentifier,
  });

  @override
  IOSNotificationConfig copyWith({
    bool? presentAlert,
    bool? presentBadge,
    bool? presentSound,
    String? sound,
    int? badgeNumber,
    String? subtitle,
    String? threadIdentifier,
  }) {
    return IOSNotificationConfig(
      presentAlert: presentAlert ?? this.presentAlert,
      presentBadge: presentBadge ?? this.presentBadge,
      presentSound: presentSound ?? this.presentSound,
      sound: sound ?? this.sound,
      badgeNumber: badgeNumber ?? this.badgeNumber,
      subtitle: subtitle ?? this.subtitle,
      threadIdentifier: threadIdentifier ?? this.threadIdentifier,
    );
  }
}
