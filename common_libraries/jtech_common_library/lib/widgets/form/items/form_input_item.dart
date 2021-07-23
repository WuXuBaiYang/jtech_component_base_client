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

  //输入框样式控制
  final InputDecoration inputDecoration;

  //最小行数
  final int minLines;

  //最大行数
  final int maxLines;

  //最大字符数
  final int? maxLength;

  //是否显示计数器
  final bool showCounter;

  //是否只读
  final bool readOnly;

  JFormInputItem({
    String? initialValue,
    bool enabled = true,
    TextStyle? textStyle,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    this.validRegs = const {},
    this.inputDecoration = const InputDecoration(),
    this.minLines = 1,
    int maxLines = 1,
    this.maxLength,
    this.showCounter = true,
    this.readOnly = false,
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
        this.maxLines = (maxLines < minLines) ? minLines : maxLines,
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
      inputDecoration: inputDecoration.copyWith(
        counter: _buildCounter(field.value?.length),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: textStyle,
        decoration: null,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        readOnly: readOnly,
        onChanged: (value) => field.didChange(value),
      ),
      config: defaultConfig.copyWith(
        isEmpty: field.value?.isEmpty ?? true,
        isFocused: focusNode.hasFocus,
      ),
    );
  }

  //构建计数器
  Widget? _buildCounter(int? count) {
    if (showCounter && null != maxLength) {
      return Text("${count ?? 0}/$maxLength");
    }
    return null;
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
