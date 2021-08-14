import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 拍照页面
* @author jtechjh
* @Time 2021/7/30 2:30 下午
*/
class TakePhotoPageState extends BaseCameraPageState {
  //记录当前已拍摄照片数量
  final ListValueChangeNotifier<JFileInfo> photoList;

  //当前所选下标
  final ValueChangeNotifier<int> currentIndex;

  //图片预览组件控制器
  final PageController pageController;

  //最大可拍摄数量
  final int maxCount;

  TakePhotoPageState({
    this.maxCount = 1,
  })  : assert(maxCount > 0, "最大数量不可小于等于0"),
        this.photoList = ListValueChangeNotifier.empty(),
        this.currentIndex = ValueChangeNotifier(0),
        this.pageController = PageController();

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        buildCameraPreview(context),
        _buildPhotoPreview(),
        Column(
          children: [
            Expanded(child: EmptyBox(), flex: 2),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(flex: 1, child: _buildPhotoPreviewIndicator()),
                      Expanded(flex: 3, child: _buildCameraActions()),
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }

  //判断是否达到最大数量限制
  bool get hasMaxCount => maxCount <= photoList.length;

  //操作控制器跳转到某页
  void animToPage(int page) => pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 350),
        curve: Curves.ease,
      );

  //构建图片预览组件
  Widget _buildPhotoPreview() {
    return ValueListenableBuilder<List<JFileInfo>>(
      valueListenable: photoList,
      builder: (context, photoList, child) {
        var offset = (hasMaxCount || photoList.isEmpty) ? 0 : 1;
        return PageView(
          controller: pageController,
          onPageChanged: (index) => currentIndex.setValue(index),
          children: List.generate(photoList.length + offset, (index) {
            if (offset > 0 && index == 0) return EmptyBox();
            var item = photoList[index - offset];
            return Container(
              color: Colors.black,
              child: JImage.file(
                item.file,
                config: ImageConfig(
                  alignment: Alignment.topCenter,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  //构建图片预览组件的指示器
  Widget _buildPhotoPreviewIndicator() {
    var borderRadius = BorderRadius.circular(4);
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, currPage, child) {
        var offset = (hasMaxCount || photoList.isEmpty) ? 0 : 1;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(photoList.length + offset, (index) {
              var selected = currPage == index;
              var takePhotoIcon = offset > 0 && index == 0;
              var child;
              if (takePhotoIcon) {
                child = Icon(
                  Icons.camera,
                  color: Colors.white,
                );
              } else {
                var item = photoList.getItem(index - offset);
                child = JImage.file(
                  item!.file,
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
                  decoration: ShapeDecoration(
                    shape: takePhotoIcon
                        ? CircleBorder()
                        : RoundedRectangleBorder(borderRadius: borderRadius),
                    color: selected ? Colors.blue : null,
                  ),
                  child: child,
                ),
                onPressed: () => animToPage(index),
              );
            }),
          ),
        );
      },
    );
  }

  //构建摄像头操作部分
  Widget _buildCameraActions() {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, currPage, child) {
        var canTakePhoto = (hasMaxCount ? 0 : 1) > 0 && currPage == 0;
        var iconData = canTakePhoto ? Icons.camera : Icons.done;
        return Row(
          children: [
            Expanded(child: EmptyBox()),
            FloatingActionButton(
              child: Icon(iconData),
              onPressed: () {
                if (canTakePhoto) {
                  Feedback.forTap(context);
                  return _takeAndPutPhoto();
                }
                //非拍照状态下，点击则会退出当前页面并返回已拍照数据
                jRouter.pop<List<JFileInfo>>(photoList.value);
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: canTakePhoto
                    ? EmptyBox()
                    : IconButton(
                        splashRadius: 25,
                        icon: Icon(Icons.delete_outline),
                        color: Colors.white,
                        onPressed: () {
                          if (!currentIndex.setValue(currPage -
                              (currPage >= photoList.length ? 1 : 0))) {
                            currentIndex.update(true);
                          }
                          photoList
                              .removeValueAt(currPage - (hasMaxCount ? 0 : 1));
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
    photoList.insertValue(0, [
      await JFileInfo.loadFromXFile(result),
    ]);
    currentIndex.update(true);
  }
}
