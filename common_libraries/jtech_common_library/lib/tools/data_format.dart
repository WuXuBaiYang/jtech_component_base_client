import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/*
* 日期格式化工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
@protected
class DataFormat {
  //全中文日期格式化
  final String fullDateTimeZH = "yyyy年MM月dd日 hh时mm分ss秒";

  //全中文日期格式化
  String formatFullDateTimeZH(DateTime dateTime) =>
      format(fullDateTimeZH, dateTime);

  //日期格式化
  String format(String pattern, DateTime dateTime) =>
      DateFormat(pattern).format(dateTime);

  //日期解析
  DateTime? parse(String date) => DateTime.tryParse(date);
}
