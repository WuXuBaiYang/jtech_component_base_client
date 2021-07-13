import 'package:flutter/cupertino.dart';

/*
* banner数据对象
* @author wuxubaiyang
* @Time 2021/7/13 下午5:14
*/
class BannerItem {
  //子项内容
  Widget content;

  //子项标题
  Widget? title;

  BannerItem({
    required this.content,
    this.title,
  });
}
