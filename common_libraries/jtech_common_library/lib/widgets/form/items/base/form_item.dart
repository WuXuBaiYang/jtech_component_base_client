import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';

/*
* 表单子项基类
* @author wuxubaiyang
* @Time 2021/7/22 下午2:49
*/
abstract class JFormItem<V> extends BaseStatefulWidget {
  //初始数据
  final V? initialValue;

  //是否可用
  final bool enabled;

  //保存事件
  final FormFieldSetter<V>? onSaved;

  //校验事件
  final FormFieldValidator<V>? validator;

  //自动校验模式
  final AutovalidateMode? autoValidateMode;

  JFormItem({
    required this.enabled,
    required this.initialValue,
    required this.autoValidateMode,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<V>(
      enabled: enabled,
      initialValue: initialValue,
      autovalidateMode: autoValidateMode,
      onSaved: (value) => onSavedValue(value),
      validator: (value) => onValidValue(value),
      builder: (field) => buildFormItem(context, field),
    );
  }

  //保存事件
  @mustCallSuper
  void onSavedValue(V? value) {
    onSaved?.call(value);
  }

  //数据校验事件
  @mustCallSuper
  String? onValidValue(V? value) {
    return validator?.call(value);
  }

  //构造主要内容
  Widget buildFormItem(BuildContext context, FormFieldState<V> field);

  //构建默认表单子项结构
  Widget buildDefaultItem({
    required FormFieldState<V> field,
    required Widget child,
    required DefaultFormItemConfig<V> config,
    InputDecoration? inputDecoration,
  }) =>
      DefaultFormItem<V>(
        child: child,
        field: field,
        config: config,
        enable: enabled,
        inputDecoration: inputDecoration,
      );
}
