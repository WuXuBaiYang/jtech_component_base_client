import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 预览页面基类
* @author jtechjh
* @Time 2021/8/23 10:38 上午
*/
class PreviewPage extends StatelessWidget {
  //预览页面配置对象
  final PreviewConfig config;

  //当前浏览下标
  final ValueChangeNotifier<int> currentIndex;

  //页面控制器
  final PageController controller;

  //数据源
  final List<JFileInfo> fileList;

  PreviewPage({
    Key? key,
    required this.config,
    required this.fileList,
    int initialIndex = 0,
  })
      : this.currentIndex = ValueChangeNotifier(initialIndex),
        this.controller = PageController(initialPage: initialIndex),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBar: _buildAppBar(),
      showAppbar: config.showAppbar,
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller,
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          var item = fileList[index];
          return Stack(
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
                onTap: () => _popPreview(),
              ),
              config.itemBuilder?.call(context, item, index) ??
                  Center(child: _buildPreviewItem(item, index)),
            ],
          );
        },
      ),
    );
  }

  //构建标题栏
  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, value, child) => Text(getTitle()),
      ),
      centerTitle: config.centerTitle,
      backgroundColor: config.appbarColor,
      leading: config.backButton ?? BackButton(),
    );
  }

  //获取标题
  String getTitle() {
    if (!config.showCounter) return config.title;
    return "${config.title}(${currentIndex.value}/${fileList.length})";
  }

  //构建预览子项
  Widget _buildPreviewItem(JFileInfo fileInfo, int index) {
    if (fileInfo.isImageType) {
      return Hero(
        tag: fileInfo.uri,
        child: GestureDetector(
          child: JImage.fileInfo(
            fileInfo,
            width: double.maxFinite,
            config: ImageConfig(
              color: Colors.white,
            ),
            placeholderBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
            errorBuilder: (context, error, stackTrace) =>
                Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white,
                  size: 55,
                ),
            gestureConfig: ImageGestureConfig(
              inPageView: true,
            ),
          ),
          onTap: () => _popPreview(),
        ),
      );
    }
    if (fileInfo.isVideoType) {
      return JVideoPlayer.fileInfo(
        fileInfo: fileInfo,
        backgroundColor: Colors.black,
        allowedScreenSleep: false,
        allowFullScreen: false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
      );
    }
    if (fileInfo.isAudioType) {
      return JAudioPlayer.full(
        dataSource: AudioDataSource.fileInfo(fileInfo),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 55,
        ),
        SizedBox(height: 8),
        Text(
          "不支持的文件类型",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  //推出预览
  void _popPreview() => jRouter.pop(currentIndex.value);
}
