import 'dart:core';
import 'package:flutter/widgets.dart';
import 'default_form_item.dart';

/*
* 默认表单子项配置
* @author wuxubaiyang
* @Time 2021/7/22 下午4:48
*/
class DefaultFormItemConfig<V> {
  //内间距
  EdgeInsetsGeometry padding;

  //内容部分内间距
  EdgeInsetsGeometry contentPadding;

  //水平方向
  bool vertical;

  //点击事件
  OnFormItemTap<V>? onTap;

  //长点击事件
  OnFormItemLongTap<V>? onLongTap;

  //头部-图标
  Widget? leading;

  //头部-标题
  Widget? title;

  //头部-必填标记
  bool required;

  //尾部-文本描述
  Widget? desc;

  //尾部-图标
  Widget? trailing;

  //尾部-是否显示箭头，true则trailing失效
  bool isArrow;

  //通用-头尾中的元素间距
  double space;

  DefaultFormItemConfig({
    this.padding = const EdgeInsets.all(15),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.vertical = false,
    this.onTap,
    this.onLongTap,
    this.leading,
    this.title,
    this.required = false,
    this.desc,
    this.trailing,
    this.isArrow = false,
    this.space = 4.0,
  });

  DefaultFormItemConfig<V> copyWith({
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    bool? vertical,
    OnFormItemTap<V>? onTap,
    OnFormItemLongTap<V>? onLongTap,
    Widget? leading,
    Widget? title,
    bool? required,
    Widget? desc,
    Widget? trailing,
    bool? isArrow,
    double? space,
  }) {
    return DefaultFormItemConfig<V>(
      padding: padding ?? this.padding,
      contentPadding: contentPadding ?? this.contentPadding,
      vertical: vertical ?? this.vertical,
      onTap: onTap ?? this.onTap,
      onLongTap: onLongTap ?? this.onLongTap,
      leading: leading ?? this.leading,
      title: title ?? this.title,
      required: required ?? this.required,
      desc: desc ?? this.desc,
      trailing: trailing ?? this.trailing,
      isArrow: isArrow ?? this.isArrow,
      space: space ?? this.space,
    );
  }
}
