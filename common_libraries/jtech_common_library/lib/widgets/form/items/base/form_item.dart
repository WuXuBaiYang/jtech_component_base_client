import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/form/items/base/config.dart';

/*
* 表单子项基类
* @author wuxubaiyang
* @Time 2021/7/22 下午2:49
*/
class JFormItem<V> extends BaseStatefulWidget {
  //当前状态对象
  final BaseJFormItemState currentState;

  //构建一个输入框表单子项
  JFormItem.input({
    //基本属性
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    FormItemConfig<String>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<String>? onTap,
    OnFormItemTap<String>? onLongTap,
    DefaultItemConfig<String>? defaultConfig,
    //输入框属性
    TextStyle? textStyle,
    Map<RegExp, String> validRegs = const {},
    InputDecoration inputDecoration = const InputDecoration(),
    int minLines = 1,
    int maxLines = 1,
    int? maxLength,
    bool showCounter = true,
    bool readOnly = false,
    TextAlign textAlign = TextAlign.start,
    bool obscureText = false,
    bool? showObscureButton,
    bool showClearButton = false,
    TextInputAction? inputAction,
    OnInputAction? onEditingComplete,
    OnInputAction? onSubmitted,
    List<TextInputFormatter> inputFormatters = const [],
  }) : this.currentState = JFormInputItemState(
          initialValue: initialValue,
          textStyle: textStyle,
          validRegs: validRegs,
          inputDecoration: inputDecoration,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          showCounter: showCounter,
          readOnly: readOnly,
          textAlign: textAlign,
          obscureText: obscureText,
          showObscureButton: showObscureButton,
          showClearButton: showClearButton,
          inputAction: inputAction,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          config: (baseConfig ?? FormItemConfig<String>()).copyWith(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
          ),
          defaultConfig:
              (defaultConfig ?? DefaultItemConfig<String>()).copyWith(
            title: title,
            leading: leading,
            isArrow: isArrow,
            onTap: onTap,
            onLongTap: onLongTap,
          ),
        );

  //构建头像表单项
  JFormItem.avatar({
    //基本属性
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    FormItemConfig<String>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<String>? onTap,
    OnFormItemTap<String>? onLongTap,
    DefaultItemConfig<String>? defaultConfig,
    //头像属性
    required String url,
  }) : this.currentState = JFormAvatarItemState(
          url: url,
          config: (baseConfig ?? FormItemConfig<String>()).copyWith(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
          ),
          defaultConfig:
              (defaultConfig ?? DefaultItemConfig<String>()).copyWith(
            title: title,
            leading: leading,
            isArrow: isArrow,
            onTap: onTap,
            onLongTap: onLongTap,
          ),
        );

  //构建自定义表单项
  JFormItem.custom({
    //基本属性
    V? initialValue,
    FormFieldSetter<V>? onSaved,
    FormFieldValidator<V>? validator,
    FormItemConfig<V>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<V>? onTap,
    OnFormItemTap<V>? onLongTap,
    DefaultItemConfig<V>? defaultConfig,
    //自定义项属性
    required FormFieldBuilder<V> builder,
  }) : this.currentState = JFormCustomItemState<V>(
          builder: builder,
          config: (baseConfig ?? FormItemConfig<V>()).copyWith(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
          ),
          defaultConfig: (defaultConfig ?? DefaultItemConfig<V>()).copyWith(
            title: title,
            leading: leading,
            isArrow: isArrow,
            onTap: onTap,
            onLongTap: onLongTap,
          ),
        );

  //构建开关表单项
  JFormItem.switchX({
    //基本属性
    bool? initialValue,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    FormItemConfig<bool>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<bool>? onTap,
    OnFormItemTap<bool>? onLongTap,
    DefaultItemConfig<bool>? defaultConfig,
    //开关项属性
    Alignment alignment = Alignment.centerRight,
    bool clickFullArea = true,
  }) : this.currentState = JFormSwitchItemState(
          alignment: alignment,
          clickFullArea: clickFullArea,
          config: (baseConfig ?? FormItemConfig<bool>()).copyWith(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
          ),
          defaultConfig: (defaultConfig ?? DefaultItemConfig<bool>()).copyWith(
            title: title,
            leading: leading,
            isArrow: isArrow,
            onTap: onTap,
            onLongTap: onLongTap,
          ),
        );

  //构建文本表单项
  JFormItem.text({
    //基本属性
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    FormItemConfig<String>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<String>? onTap,
    OnFormItemTap<String>? onLongTap,
    DefaultItemConfig<String>? defaultConfig,
    //文本项属性
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.start,
  }) : this.currentState = JFormTextItemState(
    textStyle: textStyle,
    textAlign: textAlign,
    config: (baseConfig ?? FormItemConfig<String>()).copyWith(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
    ),
    defaultConfig: (defaultConfig ?? DefaultItemConfig<String>()).copyWith(
      title: title,
      leading: leading,
      isArrow: isArrow,
      onTap: onTap,
      onLongTap: onLongTap,
    ),
  );

  @override
  BaseJFormItemState getState() => currentState;
}

/*
* 表单子项状态基类
* @author jtechjh
* @Time 2021/8/13 1:20 下午
*/
abstract class BaseJFormItemState<V> extends BaseState<JFormItem> {
  //表单子项基本配置信息
  final FormItemConfig<V> config;

  //默认表单项配置文件
  final DefaultItemConfig<V>? defaultConfig;

  BaseJFormItemState({
    required this.config,
    this.defaultConfig,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<V>(
      enabled: config.enabled,
      initialValue: config.initialValue,
      autovalidateMode: config.autoValidateMode,
      onSaved: (value) => onSavedValue(value),
      validator: (value) => onValidValue(value),
      builder: (field) => buildFormItem(context, field),
    );
  }

  //保存事件
  @mustCallSuper
  void onSavedValue(V? value) => config.onSaved?.call(value);

  //数据校验事件
  @mustCallSuper
  String? onValidValue(V? value) => config.validator?.call(value);

  //构造主要内容
  Widget buildFormItem(BuildContext context, FormFieldState<V> field);

  //构建默认表单子项结构
  Widget buildDefaultItem({
    required FormFieldState<V> field,
    required Widget child,
    DefaultItemConfig<V>? defaultConfig,
    InputDecoration? inputDecoration,
  }) =>
      DefaultItem<V>(
        child: child,
        field: field,
        config: defaultConfig ?? this.defaultConfig,
        enable: config.enabled,
        inputDecoration: inputDecoration,
      );
}
