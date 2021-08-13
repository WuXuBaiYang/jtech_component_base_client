import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单开关项
* @author wuxubaiyang
* @Time 2021/7/23 下午4:00
*/
class JFormSwitchItemState extends BaseJFormItemState<bool> {
  //开关对齐位置
  final Alignment alignment;

  //点击范围，是否整个item点击触发
  final bool clickFullArea;

  JFormSwitchItemState({
    //默认参数结构
    required FormItemConfig<bool> config,
    DefaultItemConfig<bool>? defaultConfig,
    //开关表单项参数结构
    this.alignment = Alignment.centerRight,
    this.clickFullArea = true,
  }) : super(config: config, defaultConfig: defaultConfig);

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
      defaultConfig: defaultConfig?.copyWith(
        onTap: clickFullArea
            ? (value) {
                if (clickFullArea) {
                  value = !value!;
                  field.didChange(value);
                }
                defaultConfig?.onTap?.call(value);
              }
            : defaultConfig?.onTap,
      ),
    );
  }
}
