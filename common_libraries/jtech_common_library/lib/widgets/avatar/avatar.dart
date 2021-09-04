import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

//头像选择完成后，异步上传回调(如果传空或者异常，则不会刷新当前所选图片)
typedef OnAvatarUpload = Future<JFileInfo?> Function(String path);

//头像点击事件
typedef OnAvatarTap = void Function(ImageDataSource dataSource);

/*
* 头像组件
* @author wuxubaiyang
* @Time 2021/7/26 上午10:53
*/
class JAvatar extends BaseStatelessWidget {
  //头像上传回调(为空则不执行上传操作)
  final OnAvatarUpload? onAvatarUpload;

  //头像点击事件
  final OnAvatarTap? onAvatarTap;

  //背景色
  final Color color;

  //悬浮高度
  final double elevation;

  //图片资源管理
  final ValueChangeNotifier<ImageDataSource> dataSource;

  //占位图
  final ErrorBuilder? errorBuilder;

  //占位图构造器
  final PlaceholderBuilder? placeholderBuilder;

  //头像尺寸（1：1）
  final double size;

  //判断是否为圆形头像
  final bool circle;

  //为矩形时的圆角度数
  final BorderRadius borderRadius;

  //内间距
  final EdgeInsets padding;

  //外间距
  final EdgeInsets margin;

  //选择头像菜单集合
  final List<PickerMenuItem> pickerMenuItems;

  JAvatar({
    required ImageDataSource dataSource,
    this.onAvatarUpload,
    this.onAvatarTap,
    this.color = Colors.white,
    this.elevation = 0.0,
    this.placeholderBuilder,
    this.errorBuilder,
    this.size = 45,
    this.circle = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.pickerMenuItems = const [],
  })  : assert(
          pickerMenuItems.isNotEmpty && null != onAvatarUpload,
          "当启用头像选择时，头像上传功能不能为空",
        ),
        this.dataSource = ValueChangeNotifier(dataSource);

  //矩形头像
  JAvatar.square({
    required ImageDataSource dataSource,
    OnAvatarUpload? onAvatarUpload,
    OnAvatarTap? onAvatarTap,
    Color color = Colors.white,
    double elevation = 0.0,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double size = 45,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this(
          dataSource: dataSource,
          onAvatarUpload: onAvatarUpload,
          onAvatarTap: onAvatarTap,
          color: color,
          elevation: elevation,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          size: size,
          borderRadius: borderRadius,
          margin: margin,
          padding: padding,
          circle: false,
          pickerMenuItems: _generatePickerMenu(pickImage, takePhoto),
        );

  //圆形头像
  JAvatar.circle({
    required ImageDataSource dataSource,
    OnAvatarUpload? onAvatarUpload,
    OnAvatarTap? onAvatarTap,
    Color color = Colors.white,
    double elevation = 0.0,
    PlaceholderBuilder? placeholderBuilder,
    ErrorBuilder? errorBuilder,
    double size = 45,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    bool pickImage = false,
    bool takePhoto = false,
  }) : this(
    dataSource: dataSource,
    onAvatarUpload: onAvatarUpload,
    onAvatarTap: onAvatarTap,
    color: color,
    elevation: elevation,
    placeholderBuilder: placeholderBuilder,
    errorBuilder: errorBuilder,
    size: size,
    borderRadius: borderRadius,
    margin: margin,
    padding: padding,
    circle: true,
    pickerMenuItems: _generatePickerMenu(pickImage, takePhoto),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: JCard.single(
        child: _buildAvatar(context),
        borderRadius: borderRadius,
        elevation: elevation,
        padding: padding,
        margin: margin,
        circle: circle,
        color: color,
      ),
      onTap: () => _onAvatarTap(context),
    );
  }

  //构建头像
  Widget _buildAvatar(BuildContext context) {
    return ValueListenableBuilder<ImageDataSource>(
      valueListenable: dataSource,
      builder: (context, value, child) {
        return JImage(
          size: size,
          fit: BoxFit.fill,
          dataSource: value,
          clip: circle
              ? ImageClipOval()
              : ImageClipRRect(borderRadius: borderRadius),
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
        );
      },
    );
  }

  //头像点击事件
  void _onAvatarTap(BuildContext context) async {
    onAvatarTap?.call(dataSource.value);
    if (pickerMenuItems.isEmpty) return;
    var result = await jFilePicker.pick(
      context,
      items: pickerMenuItems,
    );
    if (null != result && result.isNoEmpty) {
      var fileInfo = result.singleFile;
      fileInfo = await onAvatarUpload!(fileInfo!.uri);
      if (null == fileInfo) return;
      dataSource.setValue(
        ImageDataSource.fileInfo(fileInfo),
      );
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
