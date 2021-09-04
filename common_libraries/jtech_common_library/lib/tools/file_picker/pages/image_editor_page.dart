import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 图片编辑页
* @author jtechjh
* @Time 2021/9/4 11:28 上午
*/
class ImageEditorPagePage extends BaseStatefulPage {
  //图片资源管理
  final ImageDataSource dataSource;

  //最大缩放比例
  final double maxScale;

  //裁剪比例
  final ValueChangeNotifier<double> currentCropRatio;

  //是否启用比例切换功能
  final bool enableRatioMenu;

  ImageEditorPagePage(
    this.dataSource, {
    this.maxScale = 3.0,
    double? initialCropRatio,
    this.enableRatioMenu = true,
  }) : this.currentCropRatio = ValueChangeNotifier(initialCropRatio ?? -1);

  @override
  BaseState<ImageEditorPagePage> getState() => _ImageEditorPagePageState();

  //更新当前裁剪比例
  void updateCropRatio(double? ratio) => currentCropRatio.setValue(ratio ?? -1);
}

/*
* 图片编辑页状态
* @author jtechjh
* @Time 2021/9/4 11:28 上午
*/
class _ImageEditorPagePageState extends BaseState<ImageEditorPagePage> {
  //图片编辑控制器
  final editorController = ImageEditorController();

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "图片编辑页",
      appBarActions: [
        IconButton(
          icon: Icon(Icons.done),
          onPressed: () => _confirmEditor(),
        ),
      ],
      body: ValueListenableBuilder<double>(
        valueListenable: widget.currentCropRatio,
        builder: (context, value, child) => JImage(
          dataSource: widget.dataSource,
          editorConfig: ImageEditorConfig(
            controller: editorController,
            maxScale: widget.maxScale,
            cropAspectRatio: value < 0 ? null : value,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          children: [
            Visibility(
              child: _buildActionItem(
                iconData: Icons.crop,
                text: "裁剪",
                onTap: () => _showCropMenu(context),
              ),
              visible: widget.enableRatioMenu,
            ),
            _buildActionItem(
              iconData: Icons.flip,
              text: "镜像",
              onTap: () => editorController.flip(),
            ),
            _buildActionItem(
              iconData: Icons.rotate_left,
              text: "左转",
              onTap: () => editorController.rotateLeft90(),
            ),
            _buildActionItem(
              iconData: Icons.rotate_right,
              text: "右转",
              onTap: () => editorController.rotateRight90(),
            ),
            _buildActionItem(
              iconData: Icons.history,
              text: "重置",
              onTap: () => editorController.reset(),
            ),
          ],
        ),
      ),
    );
  }

  //构建底部操作菜单子项
  Widget _buildActionItem({
    required IconData iconData,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, color: Colors.white),
              SizedBox(height: 4),
              Text(text, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  //确认编辑
  Future<void> _confirmEditor() async {
    var result = await editorController.cropImage();
    return jRouter.pop(result);
  }

  //展示裁剪菜单
  Future<void> _showCropMenu(BuildContext context) async {
    var result = await jSheet.showCustomBottomSheet<double>(
      context,
      config: SheetConfig(
        sheetColor: Colors.blue,
        padding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        cancelTap: () => widget.currentCropRatio.value,
        content: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRatioItem(
                text: "自定义",
                onTap: () => jRouter.pop(-1.0),
              ),
              _buildRatioItem(
                text: "原始",
                onTap: () => jRouter.pop(0.0),
              ),
              _buildRatioItem(
                text: "1:1",
                onTap: () => jRouter.pop(1.0),
              ),
              _buildRatioItem(
                ratio: 3.0 / 4.0,
                text: "3:4",
                onTap: () => jRouter.pop(3.0 / 4.0),
              ),
              _buildRatioItem(
                ratio: 4.0 / 3.0,
                text: "4:3",
                onTap: () => jRouter.pop(4.0 / 3.0),
              ),
              _buildRatioItem(
                ratio: 9.0 / 16.0,
                text: "9:16",
                onTap: () => jRouter.pop(9.0 / 16.0),
              ),
              _buildRatioItem(
                ratio: 16.0 / 9.0,
                text: "16:9",
                onTap: () => jRouter.pop(16.0 / 9.0),
              ),
            ],
          ),
        ),
      ),
    );
    return widget.updateCropRatio(result);
  }

  //构建比例展示视图
  Widget _buildRatioItem({
    required String text,
    required VoidCallback onTap,
    double baseSize = 65,
    double ratio = 1.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        child: Container(
          width: ratio >= 1 ? baseSize : baseSize * ratio,
          height: ratio <= 1 ? baseSize : baseSize / ratio,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.zero,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
