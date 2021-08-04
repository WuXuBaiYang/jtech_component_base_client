import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/tools/data_format.dart';
import 'package:jtech_common_library/tools/file.dart';
import 'package:jtech_common_library/tools/matches.dart';
import 'package:jtech_common_library/tools/timer/timer.dart';

import 'media.dart';

/*
* 通用工具箱
* @author wuxubaiyang
* @Time 2021/7/23 下午4:14
*/
@protected
class Tools {
  //日期格式化
  final dataFormat = DataFormat();

  //匹配工具
  final matches = Matches();

  //文件管理
  final file = FileTool();

  //媒体文件管理
  final media = MediaTool();

  //计时器工具
  final timer = JTimer();

  //生成id
  String generateID({int? seed}) {
    var time = DateTime.now().millisecondsSinceEpoch;
    return "${time}_${Random(seed ?? time).nextDouble()}";
  }
}
