import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 索引列表组件
* @author wuxubaiyang
* @Time 2021/7/8 上午9:23
*/
class JListViewIndexState<V extends BaseIndexModel>
    extends BaseJListViewState<JIndexListViewController<V>, V> {
  //索引弹出提示框配置文件
  final SusConfig susConfig;

  //索引条配置文件
  final IndexBarConfig indexBarConfig;

  JListViewIndexState({
    //列表基本参数结构
    required JIndexListViewController<V> controller,
    //索引列表组件参数结构
    SusConfig? susConfig,
    IndexBarConfig? indexBarConfig,
  })  : this.susConfig = susConfig ?? SusConfig(),
        this.indexBarConfig = indexBarConfig ?? IndexBarConfig(),
        super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<V>>(
        valueListenable: controller.dataListenable,
        builder: (context, dataList, child) {
          return AzListView(
            data: controller.dataList,
            physics: BouncingScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (context, index) =>
                buildListItem(context, dataList[index], index),
            //设置弹出提示参数
            susItemHeight: susConfig.itemHeight,
            susPosition: susConfig.position,
            susItemBuilder: (context, index) {
              var item = dataList[index];
              return SizedBox.fromSize(
                size: Size(getSusItemWidth(context), susConfig.itemHeight),
                child: susConfig.itemBuilder?.call(context, item, index) ??
                    _buildDefSusItem(item),
              );
            },
            //侧边索引条参数
            indexBarData: indexBarConfig.dataList ?? controller.indexDataList,
            indexBarWidth: indexBarConfig.width,
            indexBarHeight: indexBarConfig.height,
            indexBarItemHeight: indexBarConfig.itemHeight,
            indexBarAlignment: indexBarConfig.alignment,
            indexBarMargin: indexBarConfig.margin,
            indexBarOptions: indexBarOptions,
            indexHintBuilder: _buildIndexBarHint,
          );
        });
  }

  //获取索引条配置对象
  IndexBarOptions get indexBarOptions => IndexBarOptions(
        needRebuild: indexBarConfig.needRebuild,
        ignoreDragCancel: indexBarConfig.ignoreDragCancel,
        color: indexBarConfig.color,
        downColor: indexBarConfig.downColor,
        decoration: indexBarConfig.decoration,
        downDecoration: indexBarConfig.downDecoration,
        textStyle: indexBarConfig.textStyle,
        downTextStyle: indexBarConfig.downTextStyle,
        selectTextStyle: indexBarConfig.selectTextStyle,
        downItemDecoration: indexBarConfig.downItemDecoration,
        selectItemDecoration: indexBarConfig.selectItemDecoration,
        indexHintWidth: indexBarConfig.indexHintWidth,
        indexHintHeight: indexBarConfig.indexHintHeight,
        indexHintDecoration: indexBarConfig.indexHintDecoration,
        indexHintTextStyle: indexBarConfig.indexHintTextStyle,
        indexHintAlignment: indexBarConfig.indexHintAlignment,
        indexHintChildAlignment: indexBarConfig.indexHintChildAlignment,
        indexHintPosition: indexBarConfig.indexHintPosition,
        indexHintOffset: indexBarConfig.indexHintOffset,
      );

  //获取索引提示宽度(暂时使用屏幕宽度，想到好的解决方案再说)
  double getSusItemWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //构建索引条弹出提出项
  Widget _buildIndexBarHint(BuildContext context, String tag) {
    if (null == indexBarConfig.hintBuilder) return _buildDefIndexBarHint(tag);
    return indexBarConfig.hintBuilder!(context, tag);
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

  //构建索引条默认弹出提示框
  Widget _buildDefIndexBarHint(String tag) {
    return Container(
      width: indexBarConfig.indexHintWidth,
      height: indexBarConfig.indexHintHeight,
      decoration: indexBarConfig.indexHintDecoration,
      alignment: indexBarConfig.indexHintChildAlignment,
      child: Text(tag, style: indexBarConfig.indexHintTextStyle),
    );
  }
}
