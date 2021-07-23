import 'package:flutter/widgets.dart';

/*
* 匹配工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
@protected
class Matches {
  //匹配手机号(+86)
  bool hasPhoneNumber_86(String string) => hasMatch(
      RegExp(
          r'^((\+86)?|(\+86-)?)1(3\d|4[5-9]|5[0-35-9]|6[2567]|7[0-8]|8\d|9[0-35-9])\d{8}$'),
      string: string);

  //判断是否存在匹配内容
  bool hasMatch(Pattern pattern, {required String string}) =>
      match(pattern, string: string).isNotEmpty;

  //匹配所有内容
  Iterable<Match> match(Pattern pattern, {required String string}) =>
      pattern.allMatches(string);
}
