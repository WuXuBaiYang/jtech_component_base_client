import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

//头像选择完成后，异步上传回调(如果传空或者异常，则不会刷新当前所选图片)
typedef OnAvatarUpload = Future<String?> Function(String path);

//头像点击事件
typedef OnAvatarTap = void Function(String url);

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

  JAvatar({
    this.onAvatarUpload,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyBox();
  }
}
