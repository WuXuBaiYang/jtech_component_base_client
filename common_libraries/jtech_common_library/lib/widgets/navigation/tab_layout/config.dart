import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*
* 指示器配置
* @author wuxubaiyang
* @Time 2021/7/12 下午4:50
*/
class IndicatorConfig {
  //指示器颜色
  Color? color;

  //指示器比重
  double weight;

  //指示器内间距
  EdgeInsets padding;

  //指示器容器设置
  Decoration? decoration;

  //指示器大小(true:与tab宽度相当，false，与文本宽度相当)
  bool sizeByTab;

  IndicatorConfig({
    this.color,
    this.weight = 2.0,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.sizeByTab = true,
  });
}
