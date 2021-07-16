import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/widgets/banner/indicator/base_indicator.dart';
import 'package:jtech_common_library/widgets/banner/item.dart';

/*
* banner圆点指示器
* @author wuxubaiyang
* @Time 2021/7/16 21:51
*/
class BannerDotIndicator extends BaseBannerIndicator {
  @override
  Widget buildIndicator(BuildContext context, BannerAlign align, int itemLength,
      int currentIndex) {
    var isVertical = align.isVertical;
    var axis = isVertical ? Axis.vertical : Axis.horizontal;
    return Container(
      width: isVertical ? null : double.infinity,
      height: !isVertical ? null : double.infinity,
      padding: const EdgeInsets.all(8),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: axis,
        children: List.generate(itemLength, (index) {
          var isSelected = currentIndex == index;
          return Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 1)
                    : Border.all(color: Colors.white, width: 0.2),
                color: isSelected ? Colors.black87 : Colors.black87,
              ),
            ),
          );
        }),
      ),
    );
  }
}
