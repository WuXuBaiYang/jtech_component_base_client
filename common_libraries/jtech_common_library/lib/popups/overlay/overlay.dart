import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/popups/overlay/config.dart';

//弹层内容构造器
typedef OverlayBuilder<T> = Widget Function(
    BuildContext context, void Function(T? result) dismiss);

/*
* 弹层组件
* @author jtechjh
* @Time 2021/8/16 11:18 上午
*/
class JOverlay extends BaseManage {
  static final JOverlay _instance = JOverlay._internal();

  factory JOverlay() => _instance;

  JOverlay._internal();

  //缓存当前启用的弹层对象
  final Map<Key, OverlayEntry> _entries = {};

  //显示基础弹层组件
  Future<T?> show<T>(
    BuildContext context, {
    required OverlayBuilder<T> builder,
    required OverlayConfig config,
    required Key key,
  }) {
    Completer<T?> completer = Completer();
    var offset = config.getOffset(context);
    _entries[key] = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
              onTapDown: (_) => completer.complete(),
            ),
            Positioned(
              child: builder(
                context,
                (result) => completer.complete(result),
              ),
              width: config.size.width,
              height: config.size.height,
              left: offset.dx,
              top: offset.dy,
            ),
          ],
        ),
      ),
    );
    Overlay.of(context)?.insert(_entries[key]!);
    return completer.future
      ..whenComplete(
        () => removeOverlay([key]),
      );
  }

  //根据某个组件的GlobalKey展示弹层
  Future<T?> showByKey<T>(
    BuildContext context, {
    required GlobalKey key,
    required Size overlaySize,
    required OverlayBuilder<T> builder,
    OverlayConfig? config,
  }) {
    var renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    var rect = Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
    return show<T>(
      context,
      key: key,
      builder: builder,
      config: (config ?? OverlayConfig()).copyWith(
        size: overlaySize,
        rect: rect,
      ),
    );
  }

  //移除弹层
  void removeOverlay(List<Key> keys) =>
      keys.forEach((key) => _entries.remove(key)?.remove());
}

//单例调用
final jOverlay = JOverlay();
