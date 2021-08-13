import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单头像子项
* @author wuxubaiyang
* @Time 2021/7/26 上午10:50
*/
class JFormAvatarItemState extends BaseJFormItemState<String> {
  JFormAvatarItemState({
    //基本参数结构
    required FormItemConfig<String> config,
    DefaultItemConfig<String>? defaultConfig,
    //头像参数结构
    required String url,
  }) : super(config: config, defaultConfig: defaultConfig);

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<String> field) {
    return buildDefaultItem(
      field: field,
      child: EmptyBox(),
    );
  }
}
