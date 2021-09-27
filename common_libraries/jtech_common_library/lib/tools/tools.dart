import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart' as crypto;
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 通用工具箱
* @author wuxubaiyang
* @Time 2021/7/23 下午4:14
*/
class JTools extends BaseManage {
  static final JTools _instance = JTools._internal();

  factory JTools() => _instance;

  JTools._internal();

  //日期格式化
  final dataFormat = JDataFormat();

  //时间区间格式化
  final durationFormat = JDurationFormat();

  //匹配工具
  final matches = JMatches();

  //文件管理
  final file = JFile();

  //计时器工具
  final timer = JTimer();

  //权限管理
  final permission = JPermission();

  //文件选择器
  final filePicker = JFilePicker();

  //预览工具方法
  final preview = JPreview();

  @override
  Future<void> init() async {
    //初始化日期格式化
    await dataFormat.init();
    //初始化时间区间格式化
    await durationFormat.init();
    //初始化匹配工具
    await matches.init();
    //初始化文件管理
    await file.init();
    //初始化计时器
    await timer.init();
    //初始化权限管理
    await permission.init();
    //初始化文件选择器
    await filePicker.init();
    //预览工具方法
    await preview.init();
  }

  //生成id
  String generateID({int? seed}) {
    var time = DateTime.now().millisecondsSinceEpoch;
    return md5("${time}_${Random(seed ?? time).nextDouble()}");
  }

  //生成时间戳签名
  String getDateSign() =>
      dataFormat.format("yyyyMMddHHmmssSSS", DateTime.now());

  //生成md5
  String md5(String value) => crypto.md5.convert(utf8.encode(value)).toString();
}

//单例调用
final jTools = JTools();
