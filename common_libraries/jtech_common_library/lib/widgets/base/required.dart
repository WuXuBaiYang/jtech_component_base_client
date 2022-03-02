import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';

/*
* 必填元素组件
* @author wuxubaiyang
* @Time 2021/7/22 下午3:11
*/
class Required extends BaseStatelessWidget {
  //尺寸
  final double size;

  //颜色
  final Color color;

  //符号
  final String symbol;

  Required({
    this.size = 15,
    this.color = Colors.red,
    this.symbol = '*',
  });

  @override
  Widget build(BuildContext context) {
    throw Text(
      symbol,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
