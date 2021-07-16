import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* banner的默认圆点指示器
* @author wuxubaiyang
* @Time 2021/7/16 上午9:38
*/
class BannerDotIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BannerDotIndicatorPainter();
  }
}

/*
* painter
* @author wuxubaiyang
* @Time 2021/7/16 上午9:39
*/
class _BannerDotIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // final Paint paint = Paint();
    // paint.color = Color(0xFFFF443D);
    // paint.style = PaintingStyle.fill;
    // canvas.drawLine(p1, p2, paint);
  }
}
