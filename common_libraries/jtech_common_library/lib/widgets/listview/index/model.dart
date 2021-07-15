import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';

/*
* 索引列表数据对象基类
* @author wuxubaiyang
* @Time 2021/7/8 上午9:42
*/
abstract class BaseIndexModel extends ISuspensionBean {
  //标签
  final String tag;

  //标签拼音
  String? tagPinyin;

  //标签索引
  String? tagIndex;

  BaseIndexModel.create({required this.tag, String defIndex = "#"}) {
    tagPinyin = PinyinHelper.getPinyinE(tag);
    var tempIndex = tagPinyin?.substring(0, 1).toUpperCase();
    tagIndex = RegExp("[A-Z]").hasMatch(tempIndex ?? "") ? tempIndex : defIndex;
  }

  @override
  String getSuspensionTag() => tagIndex!;
}
