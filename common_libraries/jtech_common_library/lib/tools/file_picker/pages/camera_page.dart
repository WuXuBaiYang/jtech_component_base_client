import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 摄像头操作基础页面
* @author jtechjh
* @Time 2021/7/30 2:36 下午
*/
class CameraPage extends BaseStatefulPageMultiply {
  //是否使用前置摄像头,否则使用后置摄像头
  final ValueChangeNotifier<CameraLensDirection> cameraDirection;

  //控制器表
  final Map<CameraLensDirection, CameraController> controllerMap;

  //记录摄像头是否正在占用中
  final ValueChangeNotifier<bool> cameraBusy;

  //摄像头使用分辨率
  final CameraResolution resolution;

  //管理闪光灯状态
  final ValueChangeNotifier<FlashMode> flashMode;

  CameraPage({
    required bool front,
    required CameraResolution? resolution,
    required State<CameraPage> currentState,
  })  : this.cameraDirection = ValueChangeNotifier(CameraLensDirection.front),
        this.resolution = resolution ?? CameraResolution.medium,
        this.flashMode = ValueChangeNotifier(FlashMode.off),
        this.cameraBusy = ValueChangeNotifier(false),
        this.controllerMap = {},
        super(currentState: currentState);

  //跳转到拍照页面并返回照片数据
  static Future<List<JFileInfo>?>? takePhoto({
    int maxCount = 1,
    bool front = false,
    CameraResolution? resolution,
  }) async {
    return jRouter.push<List<JFileInfo>>(CameraPage(
      resolution: resolution,
      front: front,
      currentState: TakePhotoPageState(
        maxCount: maxCount,
      ),
    ));
  }

  //跳转到视频录制页面并返回照片数据
  static Future<List<JFileInfo>?>? recordVideo({
    int maxCount = 1,
    Duration? maxRecordDuration,
    bool front = false,
    CameraResolution? resolution,
  }) async {
    return jRouter.push<List<JFileInfo>>(CameraPage(
      resolution: resolution,
      front: front,
      currentState: RecordVideoPageState(
        maxCount: maxCount,
        maxRecordDuration: maxRecordDuration ?? Duration(seconds: 60),
      ),
    ));
  }
}

/*
* 摄像头页面状态基类
* @author wuxubaiyang
* @Time 2021/8/14 10:57
*/
abstract class BaseCameraPageState extends BaseState<CameraPage> {
  //判断当前摄像头是否为前置状态
  bool get isCameraFront =>
      widget.cameraDirection.value == CameraLensDirection.front;

  //获取当前使用的控制器
  CameraController? get controller =>
      widget.controllerMap[widget.cameraDirection.value];

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CloseButton(),
        elevation: 0.0,
        actions: [
          _buildTorchLightAction(),
          _buildCameraDirectionAction(),
        ],
      ),
      body: buildContent(context),
    );
  }

  //构建主体内容
  Widget buildContent(BuildContext context);

  //构建摄像机基础结构部分
  Widget buildCameraPreview(BuildContext context) {
    return ValueListenableBuilder<CameraLensDirection>(
      valueListenable: widget.cameraDirection,
      builder: (context, value, child) {
        return FutureBuilder<CameraController?>(
          future: _initCamera(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return CameraPreview(snap.data!);
          },
        );
      },
    );
  }

  //初始化摄像头方法
  Future<CameraController?> _initCamera() async {
    var currDirect = widget.cameraDirection.value;
    if (widget.controllerMap.containsKey(currDirect)) {
      return widget.controllerMap[currDirect]?..initialize();
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
      widget.resolution.resolutionPreset,
    )..setFocusMode(FocusMode.auto);
    await controller.initialize();
    return widget.controllerMap[currDirect] = controller;
  }

  //构建手电筒开关
  Widget _buildTorchLightAction() {
    return ValueListenableBuilder<FlashMode>(
      valueListenable: widget.flashMode,
      builder: (context, value, child) {
        if (isCameraFront) return EmptyBox();
        var isOn = value == FlashMode.torch;
        return IconButton(
          icon: Icon(isOn ? Icons.lightbulb : Icons.lightbulb_outline),
          onPressed: () {
            var newMode = isOn ? FlashMode.off : FlashMode.torch;
            controller?.setFlashMode(newMode);
            widget.flashMode.setValue(newMode);
          },
        );
      },
    );
  }

  //构建摄像头方向切换开关
  _buildCameraDirectionAction() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.cameraBusy,
      builder: (context, value, child) {
        if (value) return EmptyBox();
        return IconButton(
          icon: Icon(Icons.flip_camera_android),
          onPressed: () {
            var currDirect = widget.cameraDirection.value;
            widget.cameraDirection.setValue(
              currDirect == CameraLensDirection.front
                  ? CameraLensDirection.back
                  : CameraLensDirection.front,
            );
            widget.flashMode.update(true);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁全部摄像头
    widget.controllerMap.forEach((key, value) => value.dispose());
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

  const CameraResolution(this.resolutionPreset);

  static const low = CameraResolution(ResolutionPreset.low);

  static const medium = CameraResolution(ResolutionPreset.medium);

  static const high = CameraResolution(ResolutionPreset.high);

  static const veryHigh = CameraResolution(ResolutionPreset.veryHigh);

  static const ultraHigh = CameraResolution(ResolutionPreset.ultraHigh);

  static const max = CameraResolution(ResolutionPreset.max);
}
