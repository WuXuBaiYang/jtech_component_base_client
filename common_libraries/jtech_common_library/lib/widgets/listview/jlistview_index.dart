import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/widgets/listview/BaseListView.dart';
import 'package:lpinyin/lpinyin.dart';

/*
* 索引列表组件
* @author wuxubaiyang
* @Time 2021/7/8 上午9:23
*/
class JIndexListView<V extends BaseIndexModel>
    extends BaseListView<JIndexListViewController<V>, V> {
  //索引弹出提示框配置文件
  final SusConfig susConfig;

  //索引条配置文件
  final IndexBarConfig indexBarConfig;

  JIndexListView({
    required JIndexListViewController<V> controller,
    required ListItemBuilder<V> itemBuilder,
    this.susConfig = const SusConfig(),
    this.indexBarConfig = const IndexBarConfig(),
  }) : super(
          controller: controller,
          itemBuilder: itemBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: controller.dataList,
      physics: BouncingScrollPhysics(),
      itemCount: controller.dataLength,
      itemBuilder: _buildListItem,
      //设置弹出提示参数
      susItemHeight: susConfig.itemHeight,
      susPosition: susConfig.position,
      susItemBuilder: (context, index) {
        return SizedBox.fromSize(
          size: Size(getSusItemWidth(context), susConfig.itemHeight),
          child: _buildSusItem(context, index),
        );
      },
      //侧边索引条参数
      indexBarData: indexBarConfig.dataList ?? controller.indexDataList,
      ///
    );
  }

  //获取索引提示宽度(暂时使用屏幕宽度，想到好的解决方案再说)
  double getSusItemWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //构建列表子项
  Widget _buildListItem(BuildContext context, int index) {
    var item = controller.getItem(index);
    return itemBuilder(context, item, index);
  }

  //构建索引提示
  Widget _buildSusItem(BuildContext context, int index) {
    var item = controller.getItem(index);
    if (null == susConfig.itemBuilder) return _buildDefSusItem(item);
    return susConfig.itemBuilder!(context, item, index);
  }

  //构建默认索引
  Widget _buildDefSusItem(V item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      color: Colors.grey[200],
      child: Text(
        item.tagIndex ?? "",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

/*
* 索引列表组件控制器
* @author wuxubaiyang
* @Time 2021/7/8 上午9:26
*/
class JIndexListViewController<V extends BaseIndexModel>
    extends JListViewController<V> {
  //设置索引数据并自动排序
  void setIndexData(List<V> newData) {
    SuspensionUtil.sortListBySuspensionTag(newData);
    SuspensionUtil.setShowSuspensionStatus(newData);
    super.setData(newData);
  }

  //获取索引条数据集合
  List<String> get indexDataList => SuspensionUtil.getTagIndexList(dataList);

  @override
  void setData(List<V> newData) => throw Exception("索引组件禁止调用该方法");

  @override
  void addData(List<V> newData,
          {int insertIndex = -1, bool clearData = false}) =>
      throw Exception("索引组件禁止调用该方法");

  @override
  void filter(OnSearchListener listener) => throw Exception("索引组件禁止调用该方法");

  @override
  void clearFilter() => throw Exception("索引组件禁止调用该方法");
}

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

  const SusConfig({
    this.itemBuilder,
    this.itemHeight = 40,
    this.position,
  });
}

/*
* 索引条配置参数
* @author wuxubaiyang
* @Time 2021/7/8 上午11:35
*/
class IndexBarConfig<V extends BaseIndexModel> {
  //索引条屏幕弹出提示构造器
  final ListItemBuilder<V>? hintBuilder;

  //索引条数据
  final List<String>? dataList;

  //索引条宽度
  final double width;

  //索引条高度
  final double? height;

  //索引条子项高度
  final double itemHeight;

  //索引条位置
  final AlignmentGeometry alignment;

  //索引条外间距
  final EdgeInsetsGeometry? margin;

  const IndexBarConfig({
    this.hintBuilder,
    this.dataList,
    this.width = 30,
    this.height,
    this.itemHeight = 16,
    this.alignment = Alignment.centerRight,
    this.margin,
  });
}

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
