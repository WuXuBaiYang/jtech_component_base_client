import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';
import 'package:jtech_common_library/widgets/form/items/base/form_item.dart';

/*
* 表单自定义子项
* @author wuxubaiyang
* @Time 2021/7/23 上午9:12
*/
class JFormCustomItem<V> extends JFormItem<V> {
  //子元素
  final FormFieldBuilder<V> builder;

  //默认结构配置
  final DefaultFormItemConfig<V> defaultConfig;

  JFormCustomItem({
    required this.builder,
    V? initialValue,
    bool enabled = true,
    FormFieldSetter<V>? onSaved,
    FormFieldValidator<V>? validator,
    //默认结构部分
    required title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<V>? onTap,
    OnFormItemTap<V>? onLongTap,
    DefaultFormItemConfig<V>? defaultConfig,
  })  : this.defaultConfig =
            (defaultConfig ?? DefaultFormItemConfig()).copyWith(
          leading: leading,
          title: title,
          isArrow: isArrow,
          onTap: onTap,
          onLongTap: onLongTap,
        ),
        super(
          enabled: enabled,
          initialValue: initialValue,
          autoValidateMode: AutovalidateMode.disabled,
          onSaved: onSaved,
          validator: validator,
        );

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<V> field) {
    return buildDefaultItem(
      field: field,
      child: builder(field),
      config: defaultConfig,
    );
  }
}
