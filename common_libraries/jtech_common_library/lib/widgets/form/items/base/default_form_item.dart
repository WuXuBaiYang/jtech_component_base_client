import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/form/items/base/default_form_item_config.dart';

import 'required_view.dart';

//表单子项点击事件
typedef OnFormItemTap<V> = void Function(V? value);

/*
* 表单默认子项组件
* @author wuxubaiyang
* @Time 2021/7/22 下午4:48
*/
class DefaultFormItem<V> extends BaseStatelessWidget {
  //子元素
  final Widget child;

  //是否可用
  final bool enable;

  //表单子元素状态持有
  final FormFieldState<V> field;

  //配置文件
  final DefaultFormItemConfig<V> config;

  //输入框样式配置
  final InputDecoration inputDecoration;

  DefaultFormItem({
    required this.child,
    required this.field,
    this.enable = true,
    InputDecoration? inputDecoration,
    DefaultFormItemConfig<V>? config,
  })  : this.config = config ?? DefaultFormItemConfig(),
        this.inputDecoration = inputDecoration ??= const InputDecoration(
          border: InputBorder.none,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: config.margin,
      child: InkWell(
        child: Container(
          padding: config.padding,
          child: InputDecorator(
            isEmpty: config.isEmpty,
            isFocused: config.isFocused,
            decoration: inputDecoration.copyWith(
              errorText: field.errorText,
            ),
            child:
                config.vertical ? buildVerticalItem() : buildHorizontalItem(),
          ),
        ),
        onTap: null != config.onTap && enable
            ? () {
                Feedback.forTap(context);
                config.onTap!(field.value);
              }
            : null,
        onLongPress: null != config.onLongTap && enable
            ? () {
                Feedback.forLongPress(context);
                config.onLongTap!(field.value);
              }
            : null,
      ),
    );
  }

  //构建垂直方向布局结构
  Widget buildVerticalItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Expanded(child: buildStart()),
          Expanded(child: buildEnd()),
        ]),
        Padding(
          padding: config.contentPadding,
          child: child,
        ),
      ],
    );
  }

  //构建水平方向布局结构
  Widget buildHorizontalItem() {
    return Row(children: [
      buildStart(),
      Expanded(
        child: Padding(
          padding: config.contentPadding,
          child: child,
        ),
      ),
      buildEnd(),
    ]);
  }

  //头部基本构造
  Widget buildStart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        config.leading ?? EmptyBox(),
        buildSpace([config.leading, config.title], space: config.space),
        config.title ?? EmptyBox(),
        Visibility(
          child: RequiredView(),
          visible: config.required,
        ),
      ],
    );
  }

  //尾部基本构造
  Widget buildEnd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        config.desc ?? EmptyBox(),
        buildSpace([config.desc, config.trailing], space: config.space),
        config.trailing ?? EmptyBox(),
        Visibility(
          visible: config.isArrow,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 20,
          ),
        ),
      ],
    );
  }

  //构造间距
  Widget buildSpace(List<Widget?> targets, {required double space}) {
    if (targets.contains(null)) return EmptyBox();
    return EmptyBox.custom(space, 0);
  }
}
