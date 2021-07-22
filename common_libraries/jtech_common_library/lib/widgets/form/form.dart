import 'package:flutter/cupertino.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/widgets/form/controller.dart';

//表单分割线构造器
typedef FormDividerBuilder = Widget Function(BuildContext context, int index);

/*
* 表单容器组件
* @author wuxubaiyang
* @Time 2021/7/22 下午1:47
*/
class JFormView extends BaseStatefulWidget {
  //表单控制器
  final JFormController controller;

  //表单变化监听
  final VoidCallback? onChange;

  //自动校验模式
  final AutovalidateMode? autoValidateMode;

  //页面后退回调
  final WillPopCallback? onWillPop;

  //判断是否可滚动
  final bool canScroll;

  //表单元素集合
  final List<Widget> children;

  //外间距
  final EdgeInsetsGeometry margin;

  //内间距
  final EdgeInsetsGeometry padding;

  //表单分割线构造器
  final FormDividerBuilder? dividerBuilder;

  JFormView({
    required this.controller,
    required this.children,
    this.onChange,
    this.autoValidateMode,
    this.onWillPop,
    this.canScroll = true,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.dividerBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Form(
        key: controller.formKey,
        autovalidateMode: autoValidateMode,
        onWillPop: onWillPop,
        onChanged: onChange,
        child: _buildFormContent(context),
      ),
    );
  }

  //构建表单子项集合
  Widget _buildFormContent(BuildContext context) {
    var hasDivider = null != dividerBuilder;
    var itemLength = hasDivider ? children.length * 2 - 1 : children.length;
    return SingleChildScrollView(
      physics: scrollPhysics,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(itemLength, (index) {
          var isOdd = index.isOdd;
          index = index ~/ 2;
          if (hasDivider && isOdd) {
            return dividerBuilder!(context, index);
          }
          return children[index];
        }),
      ),
    );
  }

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}
