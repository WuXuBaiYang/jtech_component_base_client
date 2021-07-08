import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/listview/jlistview_index.dart';

/*
* 列表数据对象测试
* @author wuxubaiyang
* @Time 2021/7/6 下午2:21
*/
class ListItemModel {
  String title;
  String des;
  IconData leading;

  ListItemModel({
    required this.title,
    required this.des,
    required this.leading,
  });
}

/*
* 索引列表数据对象测试
* @author wuxubaiyang
* @Time 2021/7/8 上午10:38
*/
class IndexListItemModel extends BaseIndexModel {
  String title;
  String des;
  IconData leading;

  IndexListItemModel.create({
    required String tag,
    required this.title,
    required this.des,
    required this.leading,
  }) : super.create(tag: tag);
}
