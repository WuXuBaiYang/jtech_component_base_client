import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';
import 'package:jtech_common_library/widgets/form/items/base/form_item.dart';

/*
* 表单开关项
* @author wuxubaiyang
* @Time 2021/7/23 下午4:00
*/
class JFormSwitchItem extends JFormItem<bool> {
  //开关对齐位置
  final Alignment alignment;

  //点击范围，是否整个item点击触发
  final bool clickFullArea;

  //默认结构配置
  final DefaultFormItemConfig<bool> defaultConfig;

  JFormSwitchItem({
    required bool initialValue,
    this.alignment = Alignment.centerRight,
    this.clickFullArea = false,
    bool enabled = true,
    //默认结构部分
    required title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<bool>? onTap,
    OnFormItemLongTap<bool>? onLongTap,
    DefaultFormItemConfig<bool>? defaultConfig,
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
        );

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<bool> field) {
    return buildDefaultItem(
      field: field,
      child: Container(
        alignment: alignment,
        child: Switch(
          value: field.value!,
          onChanged: (value) => field.didChange(value),
        ),
      ),
      config: defaultConfig.copyWith(
        onTap: clickFullArea
            ? (value) {
                if (clickFullArea) {
                  value = !value!;
                  field.didChange(value);
                }
                defaultConfig.onTap?.call(value);
              }
            : defaultConfig.onTap,
      ),
    );
  }
}
