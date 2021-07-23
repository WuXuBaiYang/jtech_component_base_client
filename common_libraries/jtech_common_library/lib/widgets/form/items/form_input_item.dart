import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';
import 'package:jtech_common_library/widgets/form/items/base/form_item.dart';

/*
* 表单输入框子项
* @author wuxubaiyang
* @Time 2021/7/22 下午3:23
*/
class JFormInputItem extends JFormItem<String> {
  //输入框控制器
  final TextEditingController controller;

  //文本内容文字样式
  final TextStyle textStyle;

  //结果校验正则集合,key：正则 value：校验失败提示
  final Map<RegExp, String> validRegs;

  //默认结构配置
  final DefaultFormItemConfig<String> defaultConfig;

  //持有输入框焦点控制
  final FocusNode focusNode;

  JFormInputItem({
    String? initialValue,
    bool enabled = true,
    TextStyle? textStyle,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    this.validRegs = const {},
    //默认结构部分
    required title,
    bool? required,
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
          required: required,
        ),
        this.textStyle = textStyle ??
            TextStyle(
              color: Colors.black,
            ),
        this.controller = TextEditingController(text: initialValue),
        this.focusNode = FocusNode(),
        super(
          enabled: enabled,
          initialValue: initialValue,
          autoValidateMode: AutovalidateMode.disabled,
          onSaved: onSaved,
          validator: validator,
        );

  @override
  void initState() {
    super.initState();
    //监听焦点变化
    focusNode.addListener(() => refreshUI());
  }

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<String> field) {
    return buildDefaultItem(
      field: field,
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: textStyle,
        decoration: null,
        onChanged: (value) => field.didChange(value),
      ),
      config: defaultConfig.copyWith(
        isEmpty: field.value?.isEmpty ?? true,
        isFocused: focusNode.hasFocus,
      ),
    );
  }

  @override
  String? onValidValue(String? value) {
    var isEmptyValue = value?.isEmpty ?? true;
    if (defaultConfig.required && isEmptyValue) {
      return defaultConfig.requiredError;
    }
    if (!isEmptyValue && validRegs.isNotEmpty) {
      for (var reg in validRegs.keys) {
        if (reg.hasMatch(value!)) return validRegs[reg];
      }
    }
    return super.onValidValue(value);
  }
}
