import 'package:jtech_base_library/jbase.dart';

/*
* 时间区间格式化
* @author jtechjh
* @Time 2021/8/13 10:13 上午
*/
class JDurationFormat extends BaseManage {
  static final JDurationFormat _instance = JDurationFormat._internal();

  factory JDurationFormat() => _instance;

  JDurationFormat._internal();

  //维护一张替换表
  final Map<String, Function> _regMap = {
    "hh": (_, dur) => "${dur.inHours}".padLeft(2, '0'),
    "mm": (date, _) => "${date.minute}".padLeft(2, '0'),
    "ss": (date, _) => "${date.second}".padLeft(2, '0'),
    "h": (_, dur) => "${dur.inHours}",
    "m": (date, _) => "${date.minute}",
    "s": (date, _) => "${date.second}",
  };

  //全时间格式化
  String formatFull(Duration duration) => format("hh:mm:ss", duration);

  //时分格式化
  String formatHHMM(Duration duration) => format("hh:mm", duration);

  //分秒格式化
  String formatMMSS(Duration duration) => format("mm:ss", duration);

  //格式化时间区间
  String format(String pattern, Duration duration) {
    DateTime date = DateTime(0).add(duration);
    _regMap.forEach((key, fun) {
      if (pattern.contains(key)) {
        var value = fun(date, duration);
        pattern = pattern.replaceAll(key, value);
      }
    });
    return pattern;
  }
}

//单例调用
final jDurationFormat = JDurationFormat();

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
  Duration multiply(num n) =>
      Duration(microseconds: (this.inMicroseconds * n).toInt());

  //duration除法
  double divide(Duration duration) {
    if (this.isEmpty || duration.isEmpty) return 0.0;
    return this.inMicroseconds / duration.inMicroseconds.toDouble();
  }

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
