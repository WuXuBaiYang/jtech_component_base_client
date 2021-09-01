import 'package:intl/intl.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 日期格式化工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
class JDataFormat extends BaseManage {
  static final JDataFormat _instance = JDataFormat._internal();

  factory JDataFormat() => _instance;

  JDataFormat._internal();

  //全日期时间格式-中文
  String formatFullDateTimeZH(DateTime dateTime) =>
      format("yyyy年MM月dd日 hh时mm分ss秒", dateTime);

  //日期时间格式-中文
  String formatDateTimeZH(DateTime dateTime) =>
      format("MM月dd日 hh时mm分", dateTime);

  //全日期格式-中文
  String formatFullDateZH(DateTime dateTime) => format("yyyy年MM月dd日", dateTime);

  //日期格式-中文
  String formatDateZH(DateTime dateTime) => format("MM月dd日", dateTime);

  //全时间格式-中文
  String formatFullTimeZH(DateTime dateTime) => format("hh时mm分ss秒", dateTime);

  //时间格式-中文
  String formatTimeZH(DateTime dateTime) => format("hh时mm分", dateTime);

  //全日期时间格式
  String formatFullDateTime(DateTime dateTime) =>
      format("yyyy/MM/dd hh-mm-ss", dateTime);

  //日期时间格式
  String formatDateTime(DateTime dateTime) => format("MM/dd hh-mm", dateTime);

  //全日期格式
  String formatFullDate(DateTime dateTime) => format("yyyy/MM/dd", dateTime);

  //日期格式
  String formatDate(DateTime dateTime) => format("MM/dd", dateTime);

  //全时间格式
  String formatFullTime(DateTime dateTime) => format("hh-mm-ss", dateTime);

  //时间格式
  String formatTime(DateTime dateTime) => format("hh-mm", dateTime);

  //日期格式化
  String format(String pattern, DateTime dateTime) =>
      DateFormat(pattern).format(dateTime);

  //日期解析
  DateTime? parse(String date) => DateTime.tryParse(date);
}

//单例调用
final jDataFormat = JDataFormat();
