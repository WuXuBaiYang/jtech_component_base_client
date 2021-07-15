import 'package:flutter/cupertino.dart';

/*
* 占位或空容器用
* @author wuxubaiyang
* @Time 2021/7/8 下午4:50
*/
class EmptyBox extends SizedBox {
  //宽高为0的空盒子
  const EmptyBox() : super(width: 0, height: 0);

  //正方形宽高的空盒子
  const EmptyBox.square(double size) : super(width: size, height: size);

  //自定义宽高的空盒子
  const EmptyBox.custom(double width, double height)
      : super(width: width, height: height);
}
