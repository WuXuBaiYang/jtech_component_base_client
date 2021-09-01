import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/tools/permission/config.dart';

//回调请求失败的请求
typedef OnPermissionCheckFail = void Function(
    List<PermissionResult> failRequests);

/*
* 权限管理工具
* @author jtechjh
* @Time 2021/8/17 11:10 上午
*/
class JPermission extends BaseManage {
  static final JPermission _instance = JPermission._internal();

  factory JPermission() => _instance;

  JPermission._internal();

  //检查集合中的权限是否全部通过
  //默认将请求失败的权限通过toast提示出来，当回调不为空时则不进行toast提示
  Future<bool> checkAllGranted(
    BuildContext context, {
    required List<PermissionRequest> permissions,
    OnPermissionCheckFail? onCheckFail,
  }) async {
    List<PermissionResult> failResults = [];
    for (var item in permissions) {
      var result = await item.request();
      if (!result.isGranted) failResults.add(result);
    }
    if (failResults.isEmpty) return true;
    if (null != onCheckFail) {
      onCheckFail.call(failResults);
    } else {
      var message = failResults.map<String>((e) => e.message).join(";");
      jToast.showLongToastTxt(context, text: message);
    }
    return false;
  }

  //检查日历权限
  Future<bool> checkCalendarGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.calendar()],
      onCheckFail: onCheckFail,
    );
  }

  //检查摄像头权限
  Future<bool> checkCameraGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.camera()],
      onCheckFail: onCheckFail,
    );
  }

  //检查通讯录权限
  Future<bool> checkContactsGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.contacts()],
      onCheckFail: onCheckFail,
    );
  }

  //检查定位权限
  Future<bool> checkLocationGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.location()],
      onCheckFail: onCheckFail,
    );
  }

  //检查麦克风权限
  Future<bool> checkMicrophoneGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.microphone()],
      onCheckFail: onCheckFail,
    );
  }

  //检查传感器权限
  Future<bool> checkSensorsGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.sensors()],
      onCheckFail: onCheckFail,
    );
  }

  //检查存储权限
  Future<bool> checkStorageGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.storage()],
      onCheckFail: onCheckFail,
    );
  }

  //检查通知权限
  Future<bool> checkNotificationGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.notification()],
      onCheckFail: onCheckFail,
    );
  }

  //检查蓝牙权限
  Future<bool> checkBluetoothGranted(
    BuildContext context, {
    OnPermissionCheckFail? onCheckFail,
  }) {
    return checkAllGranted(
      context,
      permissions: [PermissionRequest.bluetooth()],
      onCheckFail: onCheckFail,
    );
  }
}

//单例调用
final jPermission = JPermission();
