import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//头像选择完成后，异步上传回调(如果传空或者异常，则不会刷新当前所选图片)
typedef OnAvatarUpload = Future<JFileInfo?> Function(String path);

/*
* 头像组件控制器
* @author jtechjh
* @Time 2021/9/4 5:17 下午
*/
class JAvatarController extends BaseController {
  //选择头像菜单集合
  final List<PickerMenuItem> _pickerMenuItems;

  //图片资源管理
  final ValueChangeNotifier<ImageDataSource> _dataSource;

  //头像上传回调(为空则不执行上传操作)
  final OnAvatarUpload? _onAvatarUpload;

  //获取资源对象监听器
  ValueListenable<ImageDataSource> get dataSourceListenable => _dataSource;

  //获取资源对象
  ImageDataSource get dataSource => _dataSource.value;

  JAvatarController({
    required ImageDataSource dataSource,
    List<PickerMenuItem> pickerMenuItems = const [],
    OnAvatarUpload? onAvatarUpload,
  })  : assert(
          pickerMenuItems.isNotEmpty && null != onAvatarUpload,
          "当启用头像选择时，头像上传功能不能为空",
        ),
        this._dataSource = ValueChangeNotifier(dataSource),
        this._pickerMenuItems = pickerMenuItems,
        this._onAvatarUpload = onAvatarUpload;

  //集成菜单功能
  JAvatarController.withMenu({
    required ImageDataSource dataSource,
    OnAvatarUpload? onAvatarUpload,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this(
          dataSource: dataSource,
          onAvatarUpload: onAvatarUpload,
          pickerMenuItems: _generatePickerMenu(pickImage, takePhoto),
        );

  //选择头像
  Future<ImageDataSource?> pickAvatar(BuildContext context) async {
    if (_pickerMenuItems.isEmpty) return null;
    var result = await jFilePicker.pick(
      context,
      items: _pickerMenuItems,
    );
    if (null != result && result.isNoEmpty) {
      var fileInfo = result.singleFile;
      fileInfo = await _onAvatarUpload!(fileInfo!.uri);
      if (null == fileInfo) return null;
      _dataSource.setValue(
        ImageDataSource.fileInfo(fileInfo),
      );
      return dataSource;
    }
  }

  //生成选择菜单
  static List<PickerMenuItem> _generatePickerMenu(
    bool pickImage,
    bool takePhoto,
  ) {
    List<PickerMenuItem> items = [];
    final List<BaseImageProcess> process = [
      ImageCompress(),
      ImageCrop(
        initialCropRatio: 1,
        enableRatioMenu: false,
      )
    ];
    if (pickImage) {
      items.add(PickerMenuItem.image(
        process: process,
      ));
    }
    if (takePhoto) {
      items.add(PickerMenuItem.imageTake(
        process: process,
      ));
    }
    return items;
  }
}
