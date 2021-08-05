import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/*
* 日期格式化工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
@protected
class DataFormat {
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

/*
* 扩展duration方法
* @author jtechjh
* @Time 2021/8/5 11:27 上午
*/
extension DurationExtension on Duration {
  //duration相减
  Duration subtract(Duration duration) {
    if (duration.compareTo(this) >= 1) return Duration();
    return Duration(
        microseconds: this.inMicroseconds - duration.inMicroseconds);
  }

  //duration相加
  Duration add(Duration duration) =>
      Duration(microseconds: this.inMicroseconds + duration.inMicroseconds);

  //duration乘法
  Duration multiply(int n) => Duration(microseconds: this.inMicroseconds * n);

  //比较差值
  Duration difference(Duration duration) => Duration(
      microseconds: (this.inMicroseconds - duration.inMicroseconds).abs());

  //小于
  bool lessThan(Duration duration) => compareTo(duration) < 0;

  //小于等于
  bool lessEqualThan(Duration duration) => compareTo(duration) <= 0;

  //大于
  bool greaterThan(Duration duration) => compareTo(duration) > 0;

  //大于等于
  bool greaterEqualThan(Duration duration) => compareTo(duration) >= 0;

  //等于
  bool equal(Duration duration) => compareTo(duration) == 0;

  //判断是否等于0
  bool get isEmpty => inMicroseconds == 0;

  //判断是否非0
  bool get isNotEmpty => inMicroseconds != 0;
}
