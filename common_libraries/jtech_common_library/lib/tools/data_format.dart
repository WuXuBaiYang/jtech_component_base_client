import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/*
* 日期格式化工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
@protected
class DataFormat {
  //全日期格式-中文
  String formatFullDateTimeZH(DateTime dateTime) =>
      format("yyyy年MM月dd日 hh时mm分ss秒", dateTime);

  //简易日期格式-中文
  String formatDateTimeZH(DateTime dateTime) =>
      format("MM月dd日 hh时mm分", dateTime);

  //年份日期格式-中文
  String formatFullDateZH(DateTime dateTime) => format("yyyy年MM月dd日", dateTime);

  //年份简易日期格式-中文
  String formatDateZH(DateTime dateTime) => format("MM月dd日", dateTime);

  //时间日期格式-中文
  String formatFullTimeZH(DateTime dateTime) => format("hh时mm分ss秒", dateTime);

  //时间简易日期格式-中文
  String formatTimeZH(DateTime dateTime) => format("hh时mm分", dateTime);

  //全日期格式
  String formatFullDateTime(DateTime dateTime) =>
      format("yyyy/MM/dd hh-mm-ss", dateTime);

  //简易日期格式
  String formatDateTime(DateTime dateTime) => format("MM/dd hh-mm", dateTime);

  //全年份格式
  String formatFullDate(DateTime dateTime) => format("yyyy/MM/dd", dateTime);

  //简易年份格式
  String formatDate(DateTime dateTime) => format("MM/dd", dateTime);

  //全时间格式
  String formatFullTime(DateTime dateTime) => format("hh-mm-ss", dateTime);

  //简易时间格式
  String formatTime(DateTime dateTime) => format("hh-mm", dateTime);

  //日期格式化
  String format(String pattern, DateTime dateTime) =>
      DateFormat(pattern).format(dateTime);

  //日期解析
  DateTime? parse(String date) => DateTime.tryParse(date);
}
