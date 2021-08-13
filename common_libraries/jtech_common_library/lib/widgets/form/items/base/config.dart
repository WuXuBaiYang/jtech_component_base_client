import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/base/base_config.dart';

/*
* 表单子项配置基类
* @author jtechjh
* @Time 2021/8/13 1:42 下午
*/
class FormItemConfig<V> extends BaseConfig {
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

  FormItemConfig({
    this.enabled = true,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.autoValidateMode,
  });

  @override
  FormItemConfig<V> copyWith({
    bool? enabled,
    V? initialValue,
    FormFieldSetter<V>? onSaved,
    FormFieldValidator<V>? validator,
    AutovalidateMode? autoValidateMode,
  }) {
    return FormItemConfig<V>(
      enabled: enabled ?? this.enabled,
      initialValue: initialValue ?? this.initialValue,
      onSaved: onSaved ?? this.onSaved,
      validator: validator ?? this.validator,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}
