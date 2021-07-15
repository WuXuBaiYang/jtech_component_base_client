import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/listview/base/base_listView.dart';

import 'model.dart';

/*
* 索引弹出提示框配置
* @author wuxubaiyang
* @Time 2021/7/8 上午10:31
*/
class SusConfig<V extends BaseIndexModel> {
  //弹出提示框子项构造
  final ListItemBuilder<V>? itemBuilder;

  //提示框高度
  final double itemHeight;

  //位置
  final Offset? position;

  SusConfig({
    this.itemBuilder,
    this.itemHeight = 40,
    this.position,
  });
}

//索引条弹出提示框构造器
typedef IndexBarHintBuilder = Widget Function(BuildContext context, String tag);

/*
* 索引条配置参数
* @author wuxubaiyang
* @Time 2021/7/8 上午11:35
*/
class IndexBarConfig {
  //索引条屏幕弹出提示构造器
  IndexBarHintBuilder? hintBuilder;

  //索引条数据
  List<String>? dataList;

  //索引条宽度
  double width;

  //索引条高度
  double? height;

  //索引条子项高度
  double itemHeight;

  //索引条位置
  AlignmentGeometry alignment;

  //索引条外间距
  EdgeInsetsGeometry? margin;

  //是否需要重建
  bool needRebuild;

  //忽略拖拽取消
  bool ignoreDragCancel;

  //颜色
  Color? color;

  //按下颜色
  Color? downColor;

  //样式
  Decoration? decoration;

  //按下样式
  Decoration? downDecoration;

  //文字样式
  TextStyle textStyle;

  //按下文字样式
  TextStyle? downTextStyle;

  //选中文字样式
  TextStyle? selectTextStyle;

  //子项按下样式
  Decoration? downItemDecoration;

  //子项选中样式
  Decoration? selectItemDecoration;

  //索引提示宽度
  double indexHintWidth;

  //索引提示高度
  double indexHintHeight;

  //索引提示样式
  Decoration indexHintDecoration;

  //索引提示文本样式
  TextStyle indexHintTextStyle;

  //索引提示位置
  Alignment indexHintAlignment;

  //索引提示子元素位置
  Alignment indexHintChildAlignment;

  //索引提示位置
  Offset? indexHintPosition;

  //索引提示偏移
  Offset indexHintOffset;

  IndexBarConfig({
    this.hintBuilder,
    this.dataList,
    this.width = 30,
    this.height,
    this.itemHeight = 16,
    this.alignment = Alignment.centerRight,
    this.margin,
    //索引条详细配置参数
    this.needRebuild = false,
    this.ignoreDragCancel = false,
    this.color,
    this.downColor,
    this.decoration,
    this.downDecoration,
    this.textStyle = const TextStyle(fontSize: 12, color: Color(0xFF666666)),
    this.downTextStyle,
    this.selectTextStyle,
    this.downItemDecoration,
    this.selectItemDecoration,
    this.indexHintWidth = 72,
    this.indexHintHeight = 72,
    this.indexHintDecoration = const BoxDecoration(
      color: Colors.black87,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    this.indexHintTextStyle =
        const TextStyle(fontSize: 24.0, color: Colors.white),
    this.indexHintAlignment = Alignment.center,
    this.indexHintChildAlignment = Alignment.center,
    this.indexHintPosition,
    this.indexHintOffset = Offset.zero,
  });
}
