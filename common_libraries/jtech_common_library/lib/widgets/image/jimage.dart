import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';
import 'package:octo_image/octo_image.dart';

/*
* 图片视图框架
* @author wuxubaiyang
* @Time 2021/7/13 上午10:44
*/
class JImage extends BaseStatelessWidget {
  //本地图片文件
  JImage.file();

  //assets图片文件
  JImage.assets();

  //内存图片文件
  JImage.memory();

  //网络图片文件
  JImage.net();

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(
          'https://blurha.sh/assets/images/img1.jpg'),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      errorBuilder: OctoError.icon(color: Colors.red),
      fit: BoxFit.cover,
    );
  }
}
