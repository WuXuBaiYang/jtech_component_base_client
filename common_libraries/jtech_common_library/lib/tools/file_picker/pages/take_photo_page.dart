import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/tools/file_picker/file_info.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';
import 'package:jtech_common_library/widgets/image/clip.dart';
import 'package:jtech_common_library/widgets/image/config.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* 拍照页面
* @author jtechjh
* @Time 2021/7/30 2:30 下午
*/
@protected
class TakePhotoPage extends BaseCameraPage {
  //记录当前已拍摄照片数量
  final ListValueChangeNotifier<JFileInfo> takePhotoList;

  //拍照按钮可视化状态管理
  final ValueChangeNotifier<bool> canTakePhoto;

  //图片预览组件控制器
  final PageController pageController;

  //最大可拍摄数量
  final int maxCount;

  TakePhotoPage({
    bool front = false,
    CameraResolution? resolution,
    this.maxCount = -1,
  })  : this.takePhotoList = ListValueChangeNotifier.empty(),
        this.canTakePhoto = ValueChangeNotifier(true),
        this.pageController = PageController(),
        super(
          front: front,
          resolution: resolution,
        );
@override
  void initState() {
    super.initState();
    //监听页面变化回调
    pageController.addListener(() {
      print("");
    });
  }
  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: canTakePhoto,
          builder: (context, canTakePhoto, child) {
            if (!canTakePhoto) return EmptyBox();
            return buildCameraPreview(context);
          },
        ),
        Column(
          children: [
            Expanded(
              flex: 2,
              child: _buildPhotoPreview(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildPhotoPreviewIndicator(),
                    ),
                    Expanded(
                      flex: 3,
                      child: _buildCameraActions(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //判断是否达到最大数量限制
  bool get isMaxCount => maxCount >= takePhotoList.length;

  //获取最大数量限制的偏移量
  int get countOffset => (isMaxCount || takePhotoList.isEmpty) ? 0 : 1;

  //构建图片预览组件
  Widget _buildPhotoPreview() {
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: takePhotoList,
      builder: (context, photoList, child) {
        var offset = countOffset;
        return PageView(
          controller: pageController,
          onPageChanged: (index) async {
            canTakePhoto.setValue(offset > 0 && index == 0);
            takePhotoList.update(true);
          },
          children: List.generate(photoList.length + offset, (index) {
            if (offset > 0 && index == 0) return EmptyBox();
            var item = photoList[index - offset];
            return JImage.file(
              item.file,
              fit: BoxFit.cover,
            );
          }),
        );
      },
    );
  }

  //构建图片预览组件的指示器
  Widget _buildPhotoPreviewIndicator() {
    var borderRadius = BorderRadius.circular(4);
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: takePhotoList,
      builder: (context, photoList, child) {
        var currPage = pageController.page;
        var offset = countOffset;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(photoList.length + offset, (index) {
              var selected = currPage == index;
              var child;
              if (offset > 0 && index == 0) {
                child = Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                );
              } else {
                var item = photoList[index - offset];
                child = JImage.file(
                  item.file,
                  config: ImageConfig(
                    clip: ImageClipRRect(
                      borderRadius: borderRadius,
                    ),
                  ),
                  fit: BoxFit.cover,
                );
              }
              return IconButton(
                icon: Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selected ? Colors.blue: null,
                    borderRadius: borderRadius,
                  ),
                  child: child,
                ),
                onPressed: () => pageController.jumpToPage(index),
              );
            }),
          ),
        );
      },
    );
  }

  //构建摄像头操作部分
  Widget _buildCameraActions() {
    return ValueListenableBuilder<bool>(
      valueListenable: canTakePhoto,
      builder: (context, canTake, child) {
        var iconData = canTake ? Icons.camera : Icons.done;
        return Row(
          children: [
            Expanded(child: EmptyBox()),
            FloatingActionButton(
              child: Icon(iconData),
              onPressed: () {
                if (canTake) return _takeAndPutPhoto();
                //非拍照状态下，点击则会退出当前页面并返回已拍照数据
                jBase.router.pop(takePhotoList.value);
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: canTake
                    ? EmptyBox()
                    : IconButton(
                        splashRadius: 25,
                        icon: Icon(Icons.delete_outline),
                        color: Colors.white,
                        onPressed: () {
                          var page = pageController.page?.round() ?? 0;
                          page -= countOffset;
                          takePhotoList.removeValueAt(page);
                          canTakePhoto.setValue(takePhotoList.isEmpty);
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  //拍照并添加照片到记录中
  void _takeAndPutPhoto() async {
    var result = await controller?.takePicture();
    if (null == result) return;
    takePhotoList.insertValue(0, [
      await JFileInfo.loadFromXFile(result),
    ]);
    pageController.jumpToPage(countOffset);
  }
}
