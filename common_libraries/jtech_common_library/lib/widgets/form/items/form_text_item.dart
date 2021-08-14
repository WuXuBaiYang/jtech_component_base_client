import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单文本子项
* @author wuxubaiyang
* @Time 2021/7/22 下午3:23
*/
class JFormTextItemState extends BaseJFormItemState<String> {
  //文本内容文字样式
  final TextStyle textStyle;

  //文本对齐方式
  final TextAlign textAlign;

  JFormTextItemState({
    TextStyle? textStyle,
    this.textAlign = TextAlign.start,
  }) : this.textStyle = textStyle ?? TextStyle(color: Colors.grey[600]);

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<String> field) {
    return buildDefaultItem(
      field: field,
      child: Text(
        field.value ?? "",
        style: textStyle,
        textAlign: textAlign,
      ),
    );
  }
}
