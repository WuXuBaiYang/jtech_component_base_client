import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:permission_handler/permission_handler.dart';

/*
* 权限请求
* @author jtechjh
* @Time 2021/8/17 1:14 下午
*/
class PermissionRequest extends BaseModel {
  //要申请的权限
  final Permission _permission;

  //权限申请描述
  final String requestMessage;

  //权限申请失败提示
  final String requestFail;

  //请求权限
  Future<PermissionResult> request() async {
    var status = await _permission.request();
    return PermissionResult.from(status,
        message: !status.isGranted ? requestFail : "");
  }

  //日历权限
  PermissionRequest.calendar({
    this.requestMessage = "请求日历权限",
    this.requestFail = "日历权限请求失败",
  }) : this._permission = Permission.calendar;

  //摄像头权限
  PermissionRequest.camera({
    this.requestMessage = "请求摄像头权限",
    this.requestFail = "摄像头权限请求失败",
  }) : this._permission = Permission.camera;

  //请求通讯录权限
  PermissionRequest.contacts({
    this.requestMessage = "请求通讯录权限",
    this.requestFail = "通讯录权限请求失败",
  }) : this._permission = Permission.contacts;

  //请求定位权限(locationAlways、locationWhenInUse)
  PermissionRequest.location({
    this.requestMessage = "请求定位权限",
    this.requestFail = "定位权限请求失败",
  }) : this._permission = Permission.location;

  //请求麦克风权限
  PermissionRequest.microphone({
    this.requestMessage = "请求麦克风权限",
    this.requestFail = "麦克风权限请求失败",
  }) : this._permission = Permission.microphone;

  //请求传感器权限
  PermissionRequest.sensors({
    this.requestMessage = "请求传感器权限",
    this.requestFail = "传感器权限请求失败",
  }) : this._permission = Permission.sensors;

  //请求麦克风权限
  PermissionRequest.speech({
    this.requestMessage = "请求麦克风权限",
    this.requestFail = "麦克风权限请求失败",
  }) : this._permission = Permission.speech;

  //请求存储权限
  PermissionRequest.storage({
    this.requestMessage = "请求存储权限",
    this.requestFail = "存储权限请求失败",
  }) : this._permission = Permission.storage;

  //请求通知权限
  PermissionRequest.notification({
    this.requestMessage = "请求通知权限",
    this.requestFail = "通知权限请求失败",
  }) : this._permission = Permission.notification;

  //请求蓝牙权限
  PermissionRequest.bluetooth({
    this.requestMessage = "请求蓝牙权限",
    this.requestFail = "蓝牙权限请求失败",
  }) : this._permission = Permission.bluetooth;

  //请求媒体库权限
  PermissionRequest.iosMediaLibrary({
    this.requestMessage = "请求媒体库权限",
    this.requestFail = "媒体库权限请求失败",
  }) : this._permission = Permission.mediaLibrary;

  //请求图片库权限
  PermissionRequest.iosPhotos({
    this.requestMessage = "请求图片库权限",
    this.requestFail = "图片库权限请求失败",
  }) : this._permission = Permission.photos;

  //请求提醒事项权限
  PermissionRequest.iosReminders({
    this.requestMessage = "请求提醒事项权限",
    this.requestFail = "提醒事项权限请求失败",
  }) : this._permission = Permission.reminders;

  //请求外部存储权限
  PermissionRequest.androidManageExternalStorage({
    this.requestMessage = "请求外部存储权限",
    this.requestFail = "外部存储权限请求失败",
  }) : this._permission = Permission.bluetooth;

  //请求系统通知权限
  PermissionRequest.androidSystemAlertWindow({
    this.requestMessage = "请求系统通知权限",
    this.requestFail = "系统通知权限请求失败",
  }) : this._permission = Permission.systemAlertWindow;

  //请求安装包权限
  PermissionRequest.androidRequestInstallPackages({
    this.requestMessage = "请求安装包权限",
    this.requestFail = "安装包权限请求失败",
  }) : this._permission = Permission.requestInstallPackages;

  //请求短信权限
  PermissionRequest.androidSms({
    this.requestMessage = "请求短信权限",
    this.requestFail = "短信权限请求失败",
  }) : this._permission = Permission.sms;

  //请求拨打电话权限
  PermissionRequest.androidPhone({
    this.requestMessage = "请求拨打电话权限",
    this.requestFail = "拨打电话权限请求失败",
  }) : this._permission = Permission.phone;
}

/*
* 权限请求结果
* @author jtechjh
* @Time 2021/8/17 1:14 下午
*/
@protected
class PermissionResult extends BaseModel {
  //存储权限申请结果
  final PermissionStatus _status;

  //提示消息
  final String message;

  PermissionResult.from(
    PermissionStatus status, {
    this.message = "",
  }) : this._status = status;

  //判断是否通过
  bool get isGranted => _status.isGranted;

  //判断是否失败
  bool get isDenied => _status.isDenied;
}
