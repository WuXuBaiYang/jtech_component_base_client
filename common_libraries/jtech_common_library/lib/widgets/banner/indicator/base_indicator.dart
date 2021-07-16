import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jtech_common_library/widgets/banner/item.dart';

/*
* banner指示器
* @author wuxubaiyang
* @Time 2021/7/13 下午4:45
*/
abstract class BaseBannerIndicator {
  //构建入口方法
  Widget build(
    BuildContext context,
    ValueListenable<int> indexListenable,
    int itemLength,
    BannerAlign align,
  ) =>
      ValueListenableBuilder<int>(
        valueListenable: indexListenable,
        builder: (context, currentIndex, child) =>
            buildIndicator(context, align, itemLength, currentIndex),
      );

  //构建指示器
  Widget buildIndicator(BuildContext context, BannerAlign align, int itemLength,
      int currentIndex);
}
