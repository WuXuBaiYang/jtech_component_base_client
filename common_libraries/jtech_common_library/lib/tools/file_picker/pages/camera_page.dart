import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';

/*
* 摄像头操作基础页面
* @author jtechjh
* @Time 2021/7/30 2:36 下午
*/
@protected
abstract class BaseCameraPage extends BasePage {
  //是否使用前置摄像头,否则使用后置摄像头
  final ValueChangeNotifier<CameraLensDirection> _cameraDirection;

  //控制器表
  final Map<CameraLensDirection, CameraController> _controllerMap;

  //记录摄像头是否正在占用中
  final ValueChangeNotifier<bool> _cameraBusy;

  //摄像头使用分辨率
  final CameraResolution resolution;

  //管理闪光灯状态
  final ValueChangeNotifier<FlashMode> _flashMode;

  BaseCameraPage({
    required bool front,
    required CameraResolution? resolution,
  })  : this._cameraDirection = ValueChangeNotifier(CameraLensDirection.front),
        this.resolution = resolution ?? CameraResolution.medium,
        this._flashMode = ValueChangeNotifier(FlashMode.off),
        this._cameraBusy = ValueChangeNotifier(false),
        this._controllerMap = {};

  //获取当前摄像头方向
  CameraLensDirection get cameraDirect => _cameraDirection.value;

  //判断当前摄像头是否为前置状态
  bool get isCameraFront => cameraDirect == CameraLensDirection.front;

  //获取当前使用的控制器
  CameraController? get controller => _controllerMap[cameraDirect];

  //判断摄像头是否正在使用中
  bool get isCameraBusy => _cameraBusy.value;

  //设置当前摄像头操作状态
  set cameraBusy(bool busy) => _cameraBusy.setValue(busy);

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: '',
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CloseButton(),
        actions: [
          ValueListenableBuilder<FlashMode>(
            valueListenable: _flashMode,
            builder: (context, value, child) {
              if (isCameraFront) return EmptyBox();
              var isOn = value == FlashMode.torch;
              return IconButton(
                icon: Icon(isOn ? Icons.lightbulb : Icons.lightbulb_outline),
                onPressed: () {
                  var newMode = isOn ? FlashMode.off : FlashMode.torch;
                  controller?.setFlashMode(newMode);
                  _flashMode.setValue(newMode);
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _cameraBusy,
            builder: (context, value, child) {
              if (value) return EmptyBox();
              return IconButton(
                icon: Icon(Icons.flip_camera_android),
                onPressed: () {
                  var currDirect = _cameraDirection.value;
                  _cameraDirection.setValue(
                    currDirect == CameraLensDirection.front
                        ? CameraLensDirection.back
                        : CameraLensDirection.front,
                  );
                  _flashMode.update(true);
                },
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<CameraLensDirection>(
        valueListenable: _cameraDirection,
        builder: (context, value, child) {
          return FutureBuilder<CameraController?>(
            future: _initCamera(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Stack(
                children: [
                  CameraPreview(snap.data!),
                  buildCameraContent(context),
                ],
              );
            },
          );
        },
      ),
    );
  }

  //构建摄像机内容视图
  Widget buildCameraContent(BuildContext context);

  //初始化摄像头方法
  Future<CameraController?> _initCamera() async {
    var currDirect = _cameraDirection.value;
    if (_controllerMap.containsKey(currDirect)) {
      return _controllerMap[currDirect]?..initialize();
    }
    var cameras = await availableCameras();
    //根据当前状态查找目标摄像头
    CameraDescription? target;
    for (var item in cameras) {
      if (item.lensDirection == currDirect) {
        target = item;
      }
    }
    var controller = CameraController(
      target ?? cameras[0],
      resolution.resolutionPreset,
    );
    await controller.initialize();
    return _controllerMap[currDirect] = controller;
  }

  @override
  void dispose() {
    super.dispose();
    //销毁全部摄像头
    _controllerMap.forEach((key, value) => value.dispose());
  }
}

/*
* 清晰度枚举
* @author jtechjh
* @Time 2021/7/30 4:20 下午
*/
class CameraResolution {
  //清晰度枚举
  final ResolutionPreset resolutionPreset;

  @protected
  const CameraResolution(this.resolutionPreset);

  static const low = CameraResolution(ResolutionPreset.low);

  static const medium = CameraResolution(ResolutionPreset.medium);

  static const high = CameraResolution(ResolutionPreset.high);

  static const veryHigh = CameraResolution(ResolutionPreset.veryHigh);

  static const ultraHigh = CameraResolution(ResolutionPreset.ultraHigh);

  static const max = CameraResolution(ResolutionPreset.max);
}
