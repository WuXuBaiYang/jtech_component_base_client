import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  //编辑操作是否可用
  final bool modify;

  //子项预览视图表
  final Map<RegExp, Widget>? itemThumbnailMap;

  JAccessoryRefreshState({
    this.maxCount = 9,
    this.addButton,
    this.deleteButton,
    this.deleteAlign = Alignment.topRight,
    this.canScroll = true,
    required this.menuItems,
    this.onFilePreview,
    this.itemPadding = const EdgeInsets.all(8),
    this.itemRadius = const BorderRadius.all(Radius.circular(8)),
    this.modify = true,
    this.itemThumbnailMap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.config.margin,
      child: ValueListenableBuilder<List<JFileInfo>>(
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
      ),
    );
  }

  //构建附件添加子项
  Widget _buildGridItemAdd(BuildContext context, int index) {
    return Padding(
      padding: itemPadding,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: itemRadius,
        ),
        child: InkWell(
          borderRadius: itemRadius,
          child: addButton ??
              Container(
                decoration: BoxDecoration(
                  borderRadius: itemRadius,
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 55,
                  color: Colors.black26,
                ),
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
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: itemPadding,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: itemRadius,
              ),
              child: InkWell(
                borderRadius: itemRadius,
                child: widget.itemBuilder?.call(context, item, index) ??
                    _buildGridItemThumbnail(context, item, index),
                onTap: () async {
                  widget.config.itemTap?.call(item, index);
                  var totalLength = widget.controller.dataList.length;
                  var result = onFilePreview?.call(item, totalLength, index);
                  if (result ?? false) _filePreview(item, totalLength, index);
                },
                onLongPress: null != widget.config.itemLongTap
                    ? () => widget.config.itemLongTap!(item, index)
                    : null,
              ),
            ),
          ),
        ),
        Align(
          alignment: deleteAlign,
          child: deleteButton ??
              JCard.single(
                elevation: 1,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: IconButton(
                  splashRadius: 14,
                  padding: EdgeInsets.all(6),
                  iconSize: 18,
                  color: Colors.black26,
                  icon: Icon(Icons.close),
                  constraints: BoxConstraints(
                    minHeight: 20,
                    minWidth: 20,
                  ),
                  onPressed: () => widget.controller.remove(item),
                ),
                circle: true,
              ),
        ),
      ],
    );
  }

  //构建表格子项的缩略图
  Widget _buildGridItemThumbnail(
    BuildContext context,
    JFileInfo item,
    int index,
  ) {
    //优先匹配用户定义的对照表
    if (null != itemThumbnailMap && itemThumbnailMap!.isNotEmpty) {
      var patternStr = "${item.uri}${item.suffixes}";
      for (var pattern in itemThumbnailMap!.keys) {
        if (jMatches.hasMatch(pattern, string: patternStr)) {
          return itemThumbnailMap![item]!;
        }
      }
    }
    //匹配本地预设的样式
    if (item.isImageType) {
      if (item.isNetFile) {
        return JImage.net(
          item.uri,
          fit: BoxFit.cover,
          clip: ImageClipRRect(
            borderRadius: itemRadius,
          ),
        );
      }
      return JImage.file(
        item.file,
        fit: BoxFit.cover,
        clip: ImageClipRRect(
          borderRadius: itemRadius,
        ),
      );
    }
    //配置其他类型文件的预设样式
    return Container(
      alignment: Alignment.center,
      child: Opacity(
        opacity: 0.26,
        child: FaIcon(
          _fileTypeMap[item.suffixes] ?? FontAwesomeIcons.exclamation,
          size: 55,
        ),
      ),
    );
  }

  //执行文件预览
  void _filePreview(JFileInfo item, int totalLength, int index) {
    ///
  }

  //判断是否为添加按钮
  bool isAddButton(int index) =>
      modify && !hasMaxCount && index >= dataLength - 1;

  //获取数据长度
  int get dataLength =>
      widget.controller.dataList.length + (modify && hasMaxCount ? 0 : 1);

  //判断是否已达到最大数据量
  bool get hasMaxCount => widget.controller.dataList.length >= maxCount;

  //滚动控制
  ScrollPhysics? get scrollPhysics =>
      canScroll ? null : NeverScrollableScrollPhysics();
}

//预设文件类型表
final Map<String, IconData> _fileTypeMap = {
  //压缩包类型
  ".7z": FontAwesomeIcons.fileArchive,
  ".rar": FontAwesomeIcons.fileArchive,
  ".tar": FontAwesomeIcons.fileArchive,
  ".zip": FontAwesomeIcons.fileArchive,
  //视频类型
  ".avi": FontAwesomeIcons.fileVideo,
  ".mp4": FontAwesomeIcons.fileVideo,
  ".mp5": FontAwesomeIcons.fileVideo,
  ".mpge": FontAwesomeIcons.fileVideo,
  //音频类型
  ".mp3": FontAwesomeIcons.fileAudio,
  //未识别图片类型
  ".bmp": FontAwesomeIcons.fileImage,
  ".svg": FontAwesomeIcons.fileImage,
  //文档类型
  ".docx": FontAwesomeIcons.fileWord,
  ".pdf": FontAwesomeIcons.filePdf,
  ".ppt": FontAwesomeIcons.filePowerpoint,
  ".text": FontAwesomeIcons.fileAlt,
  ".txt": FontAwesomeIcons.fileAlt,
  ".xlsx": FontAwesomeIcons.fileExcel,
  "unknown": FontAwesomeIcons.exclamation,
};
