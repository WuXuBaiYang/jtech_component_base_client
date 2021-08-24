import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/route/router.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:photo_view/photo_view.dart';

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
  final PageController? controller;

  //数据源
  final List<JFileInfo> fileList;

  PreviewPage({
    Key? key,
    required this.config,
    required this.fileList,
    this.controller,
    int initialIndex = 0,
  })  : this.currentIndex = ValueChangeNotifier(initialIndex),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBar: _buildAppBar(),
      backgroundColor: config.color,
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
                onTapDown: (_) {
                  if (!config.barrierDismissible) return;
                  jRouter.pop(currentIndex.value);
                },
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
    if (!config.showAppbar) return null;
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
      return PhotoView(
        imageProvider: (fileInfo.isNetFile
            ? CachedNetworkImageProvider(fileInfo.uri)
            : FileImage(fileInfo.file)) as ImageProvider,
        heroAttributes: PhotoViewHeroAttributes(tag: fileInfo.uri),
        loadingBuilder: (context, event) {
          return CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.broken_image_outlined,
            color: Colors.black26,
            size: 55,
          );
        },
      );
    }
    if (fileInfo.isAudioType) {
      return Center(
        child: JVideoPlayer.fileInfo(
          fileInfo: fileInfo,
          allowedScreenSleep: false,
          allowFullScreen: false,
          allowMuting: false,
          allowPlaybackSpeedChanging: false,
        ),
      );
    }
    if (fileInfo.isAudioType) {
      return JAudioPlayer.full(
        dataSource: DataSource.fileInfo(fileInfo),
        fullConfig: FullAudioPlayerConfig(
          allowSpeed: false,
          allowVolume: false,
          allowSpeakerToggle: false,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.black26,
          size: 55,
        ),
        Text(
          "不支持的文件类型",
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
