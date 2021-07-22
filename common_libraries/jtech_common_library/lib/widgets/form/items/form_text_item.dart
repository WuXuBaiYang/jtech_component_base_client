import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';
import 'package:jtech_common_library/widgets/form/items/base/form_item.dart';

/*
* 表单文本子项
* @author wuxubaiyang
* @Time 2021/7/22 下午3:23
*/
class JFormTextItem extends JFormItem<String> {
  //文本内容文字样式
  final TextStyle textStyle;

  //默认结构配置
  final DefaultFormItemConfig<String> defaultConfig;

  JFormTextItem({
    required String text,
    bool enabled = true,
    TextStyle? textStyle,
    //默认结构部分
    required title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<String>? onTap,
    OnFormItemLongTap<String>? onLongTap,
    DefaultFormItemConfig<String>? defaultConfig,
  })  : this.defaultConfig =
            (defaultConfig ?? DefaultFormItemConfig()).copyWith(
          leading: leading,
          title: title,
          isArrow: isArrow,
          onTap: onTap,
          onLongTap: onLongTap,
        ),
        this.textStyle = textStyle ??
            TextStyle(
              color: Colors.grey[600],
            ),
        super(
          enabled: enabled,
          initialValue: text,
          autoValidateMode: AutovalidateMode.disabled,
        );

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<String> field) {
    return buildDefaultItem(
      field: field,
      child: Text(
        field.value ?? "",
        style: textStyle,
      ),
      config: defaultConfig,
    );
  }
}
