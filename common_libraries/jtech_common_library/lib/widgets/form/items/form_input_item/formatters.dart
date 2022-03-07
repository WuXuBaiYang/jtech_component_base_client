import 'package:flutter/services.dart';

/*
* 输入框组件内容格式化聚合
* @author wuxubaiyang
* @Time 2021/7/23 下午2:19
*/
class JInputFormatters {
  //数字类型(0-9)
  static final TextInputFormatter numbersOnly = allow(RegExp(r'[0-9]'));

  //小数类型
  static final TextInputFormatter decimalsOnly = allow(RegExp(r'[0-9]|\.'));

  //长度限制
  static TextInputFormatter limiting(int maxLength,
          {MaxLengthEnforcement? enforcement}) =>
      LengthLimitingTextInputFormatter(maxLength,
          maxLengthEnforcement: enforcement);

  //正则-通过
  static TextInputFormatter allow(Pattern pattern, {String replacement = ''}) =>
      FilteringTextInputFormatter.allow(
        pattern,
        replacementString: replacement,
      );

  //正则-不通过
  static TextInputFormatter deny(Pattern pattern, {String replacement = ''}) =>
      FilteringTextInputFormatter.deny(
        pattern,
        replacementString: replacement,
      );
}
