import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 表单头像子项
* @author wuxubaiyang
* @Time 2021/7/26 上午10:50
*/
class JFormAvatarItemState extends BaseJFormItemState<ImageDataSource> {
  JFormAvatarItemState();

  @override
  Widget buildFormItem(
      BuildContext context, FormFieldState<ImageDataSource> field) {
    return buildDefaultItem(
      field: field, child: EmptyBox(),
      // child: JAvatar(
      //   dataSource: field.value!, controller: null,
      // ),
    );
  }
}
