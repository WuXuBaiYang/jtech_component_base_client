import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';
import 'package:jtech_common_library/widgets/form/items/base/form_item.dart';

/*
* 表单头像子项
* @author wuxubaiyang
* @Time 2021/7/26 上午10:50
*/
class JFormAvatarItem extends JFormItem<String> {
  //默认结构配置
  final DefaultFormItemConfig<String> defaultConfig;

  JFormAvatarItem({
    required String url,
    bool enabled = true,
    //默认结构部分
    required title,
    Widget? leading,
    bool? isArrow,
    OnFormItemTap<String>? onTap,
    OnFormItemTap<String>? onLongTap,
    DefaultFormItemConfig<String>? defaultConfig,
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
          initialValue: url,
          autoValidateMode: AutovalidateMode.disabled,
        );

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<String> field) {
    return buildDefaultItem(
      field: field,
      child: EmptyBox(),
      config: defaultConfig,
    );
  }
}
