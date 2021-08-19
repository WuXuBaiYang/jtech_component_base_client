import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jtech_common_library/jcommon.dart';

//附件预览回调，
//返回true则使用预设方法，如无预设方法则没有任何反应,
//返回false则不会使用预设方法，需要使用者自行实现预览功能
typedef OnAccessoryFilePreview = bool Function(
    JFileInfo item, int totalCount, int index);

/*
* 刷新表格组件
* @author wuxubaiyang
* @Time 2021/7/20 下午3:15
*/
class JAccessoryRefreshState extends BaseJGridViewState<
    JAccessoryGridViewController<JFileInfo>, JFileInfo> {
  //判断是否可滚动
  final bool canScroll;

  //最大可选文件数
  final int maxCount;

  //添加按钮图标
  final Widget? addButton;

  //删除按钮图标
  final Widget? deleteButton;

  //删除按钮图标位置
  final Alignment deleteAlign;

  //附件选择子项
  final List<PickerMenuItem> menuItems;

  //子项默认内间距
  final EdgeInsets itemPadding;

  //子项圆角
  final BorderRadius itemRadius;

  //附件预览回调
  final OnAccessoryFilePreview? onFilePreview;

  JAccessoryRefreshState({
    this.maxCount = 9,
    this.addButton,
    this.deleteButton,
    this.deleteAlign = Alignment.topRight,
    this.canScroll = true,
    required this.menuItems,
    this.onFilePreview,
    this.itemPadding = const EdgeInsets.all(15),
    this.itemRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: widget.controller.dataListenable,
      builder: (context, dataList, child) {
        return StaggeredGridView.countBuilder(
          itemBuilder: (context, index) {
            if (isAddButton(index)) {
              return _buildGridItemAdd(context, index);
            }
            return _buildGridItem(context, dataList[index], index);
          },
          staggeredTileBuilder: (int index) {
            if (isAddButton(index)) {
              return widget.config.staggeredTile.staggered;
            }
            return buildGridStaggered(dataList[index], index);
          },
          mainAxisSpacing: widget.config.mainAxisSpacing,
          crossAxisSpacing: widget.config.crossAxisSpacing,
          crossAxisCount: widget.crossAxisCount,
          itemCount: dataLength,
          physics: scrollPhysics,
          shrinkWrap: true,
        );
      },
    );
  }

  //构建附件添加子项
  Widget _buildGridItemAdd(BuildContext context, int index) {
    return Padding(
      padding: itemPadding,
      child: addButton ??
          Ink(
            decoration: BoxDecoration(
                borderRadius: itemRadius,
                border: Border.all(
                  color: Colors.black26,
                )),
            child: InkWell(
              borderRadius: itemRadius,
              child: Icon(
                Icons.add_rounded,
                size: 55,
                color: Colors.black26,
              ),
              onTap: () async {
                var result = await jFilePicker.pick(
                  context,
                  items: menuItems,
                  maxCount: maxCount,
                );
                if (null != result && result.isNoEmpty) {
                  widget.controller.addData(result.files);
                }
              },
            ),
          ),
    );
  }

  //构建表格子项
  Widget _buildGridItem(BuildContext context, JFileInfo item, int index) {
    return EmptyBox();
  }

  //判断是否为添加按钮
  bool isAddButton(int index) => !hasMaxCount && index >= dataLength - 1;

  //获取数据长度
  int get dataLength =>
      widget.controller.dataList.length + (hasMaxCount ? 0 : 1);

  //判断是否已达到最大数据量
  bool get hasMaxCount => widget.controller.dataList.length >= maxCount;

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}
