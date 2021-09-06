import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单子项基类
* @author wuxubaiyang
* @Time 2021/7/22 下午2:49
*/
class JFormItem<V> extends BaseStatefulWidgetMultiply {
  //表单子项基本配置信息
  final FormItemConfig<V> config;

  //默认表单项配置文件
  final DefaultItemConfig<V>? defaultConfig;

  JFormItem({
    required State<JFormItem<V>> currentState,
    required this.config,
    this.defaultConfig,
  }) : super(currentState: currentState);

  //构建一个输入框表单子项
  static JFormItem input({
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
  }) {
    return JFormItem<String>(
      currentState: JFormInputItemState(
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
      ),
      defaultConfig: (defaultConfig ?? DefaultItemConfig()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
      config: (baseConfig ?? FormItemConfig()).copyWith(
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  //构建头像表单项
  static JFormItem avatar({
    //基本属性
    FormFieldSetter<ImageDataSource>? onSaved,
    FormFieldValidator<ImageDataSource>? validator,
    FormItemConfig<ImageDataSource>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<ImageDataSource>? onTap,
    OnFormItemTap<ImageDataSource>? onLongTap,
    DefaultItemConfig<ImageDataSource>? defaultConfig,
    //头像资源对象
    required ImageDataSource dataSource,
    Color color = Colors.white,
    double elevation = 1.0,
    ErrorBuilder? errorBuilder,
    PlaceholderBuilder? placeholderBuilder,
    double size = 35,
    bool circle = true,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsets padding = const EdgeInsets.all(2),
    bool clickFullArea = true,
    OnAvatarUpload? onAvatarUpload,
    bool pickImage = false,
    bool takePhoto = false,
    Alignment alignment = Alignment.centerRight,
  }) {
    return JFormItem<ImageDataSource>(
      currentState: JFormAvatarItemState(
        dataSource: dataSource,
        color: color,
        elevation: elevation,
        errorBuilder: errorBuilder,
        placeholderBuilder: placeholderBuilder,
        size: size,
        circle: circle,
        borderRadius: borderRadius,
        padding: padding,
        clickFullArea: clickFullArea,
        onAvatarUpload: onAvatarUpload,
        pickImage: pickImage,
        takePhoto: takePhoto,
        alignment: alignment,
      ),
      config: (baseConfig ?? FormItemConfig<ImageDataSource>()).copyWith(
        initialValue: dataSource,
        onSaved: onSaved,
        validator: validator,
      ),
      defaultConfig:
          (defaultConfig ?? DefaultItemConfig<ImageDataSource>()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
    );
  }

  //构建自定义表单项
  static JFormItem custom<V>({
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
  }) {
    return JFormItem<V>(
      currentState: JFormCustomItemState(
        builder: builder,
      ),
      config: (baseConfig ?? FormItemConfig()).copyWith(
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
      ),
      defaultConfig: (defaultConfig ?? DefaultItemConfig()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
    );
  }

  //构建开关表单项
  static JFormItem switchX({
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
  }) {
    return JFormItem<bool>(
      currentState: JFormSwitchItemState(
        alignment: alignment,
        clickFullArea: clickFullArea,
      ),
      config: (baseConfig ?? FormItemConfig()).copyWith(
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
      ),
      defaultConfig: (defaultConfig ?? DefaultItemConfig()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
    );
  }

  //构建文本表单项
  static JFormItem text({
    //基本属性
    String? text,
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
    TextAlign textAlign = TextAlign.end,
  }) {
    return JFormItem<String>(
      currentState: JFormTextItemState(
        textStyle: textStyle,
        textAlign: textAlign,
      ),
      config: (baseConfig ?? FormItemConfig()).copyWith(
        initialValue: text,
        onSaved: onSaved,
        validator: validator,
      ),
      defaultConfig: (defaultConfig ?? DefaultItemConfig()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
    );
  }

  //构建选择表单项
  static JFormItem select<T extends SelectItem>({
    //基本属性
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    FormItemConfig<List<T>>? baseConfig,
    //默认结构属性
    Widget? title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<List<T>>? onTap,
    OnFormItemTap<List<T>>? onLongTap,
    DefaultItemConfig<List<T>>? defaultConfig,
    //选择项属性
    List<T>? selectedItems,
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.end,
    List<T> originList = const [],
    OnCustomTextBuilder<T>? customTextBuilder,
    int maxSelect = 1,
    OnCustomSelectBuilder<T>? customSelectBuilder,
  }) {
    return JFormItem<List<T>>(
      currentState: JFormSelectItemState<T>(
        textStyle: textStyle,
        textAlign: textAlign,
        originList: originList,
        customTextBuilder: customTextBuilder,
        maxSelect: maxSelect,
        customSelectBuilder: customSelectBuilder,
      ),
      config: (baseConfig ?? FormItemConfig()).copyWith(
        initialValue: selectedItems,
        onSaved: onSaved,
        validator: validator,
      ),
      defaultConfig: (defaultConfig ?? DefaultItemConfig()).copyWith(
        title: title,
        leading: leading,
        isArrow: isArrow,
        onTap: onTap,
        onLongTap: onLongTap,
      ),
    );
  }
}

/*
* 表单子项状态基类
* @author jtechjh
* @Time 2021/8/13 1:20 下午
*/
abstract class BaseJFormItemState<V> extends BaseState<JFormItem<V>> {
  @override
  Widget build(BuildContext context) {
    return FormField<V>(
      enabled: widget.config.enabled,
      initialValue: widget.config.initialValue,
      autovalidateMode: widget.config.autoValidateMode,
      onSaved: (value) => onSavedValue(value),
      validator: (value) => onValidValue(value),
      builder: (field) => buildFormItem(context, field),
    );
  }

  //保存事件
  @mustCallSuper
  void onSavedValue(V? value) => widget.config.onSaved?.call(value);

  //数据校验事件
  @mustCallSuper
  String? onValidValue(V? value) => widget.config.validator?.call(value);

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
        config: defaultConfig ?? widget.defaultConfig,
        enable: widget.config.enabled,
        inputDecoration: inputDecoration,
      );
}
