import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/tools/file_picker/file_info.dart';
import 'package:jtech_common_library/tools/file_picker/pages/camera_page.dart';
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
        this.pageController = PageController(keepPage: false),
        super(
          front: front,
          resolution: resolution,
        );

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: canTakePhoto,
          builder: (context, canTakePhoto, child) => Visibility(
            child: buildCameraPreview(context),
            visible: canTakePhoto,
          ),
        ),
        Column(
          children: [
            Expanded(
              flex: 2,
              child: ValueListenableBuilder<List<JFileInfo>>(
                valueListenable: takePhotoList,
                builder: (context, photoList, child) {
                  var offset = isMaxCount ? 0 : 1;
                  return PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      canTakePhoto.setValue(offset > 0 && index == 0);

                      ///切换指示器状态
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
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _buildCameraActions(),
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

  //构建摄像头操作部分
  Widget _buildCameraActions() {
    return ValueListenableBuilder<bool>(
      valueListenable: canTakePhoto,
      builder: (context, canTake, child) {
        var iconData = canTake ? Icons.camera : Icons.done;
        return Row(
          children: [
            Expanded(
              child: canTake
                  ? EmptyBox()
                  : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => jBase.router.pop(),
                    ),
            ),
            FloatingActionButton(
              child: Icon(iconData),
              onPressed: () {
                if (canTake) return _takeAndPutPhoto();
                //非拍照状态下，点击则会退出当前页面并返回已拍照数据
                jBase.router.pop(takePhotoList.value);
              },
            ),
            Expanded(child: EmptyBox()),
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
    //定位到当前拍照所在的预览页面
    pageController.jumpToPage(isMaxCount ? 0 : 1);
    canTakePhoto.setValue(false);
  }
}
