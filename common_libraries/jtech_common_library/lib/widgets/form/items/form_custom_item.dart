import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单自定义子项
* @author wuxubaiyang
* @Time 2021/7/23 上午9:12
*/
class JFormCustomItemState<V> extends BaseJFormItemState<V> {
  //子元素
  final FormFieldBuilder<V> builder;

  JFormCustomItemState({
    required this.builder,
  });

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<V> field) {
    return buildDefaultItem(
      field: field,
      child: builder(field),
    );
  }
}
