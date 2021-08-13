import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 角标元素容器
* @author wuxubaiyang
* @Time 2021/7/16 下午2:30
*/
class JBadgeContainer<T extends BadgeConfig> extends BaseStatelessWidget {
  //角标数据监听
  final ValueChangeNotifier<T> listenable;

  //容器子元素
  final Widget child;

  //角标对齐方式
  final Alignment align;

  JBadgeContainer({
    required this.listenable,
    required this.child,
    this.align = Alignment.topRight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Align(
          alignment: align,
          child: ValueListenableBuilder<BadgeConfig>(
            valueListenable: listenable,
            builder: (context, badgeConfig, child) =>
                JBadge.create(config: badgeConfig),
          ),
        ),
      ],
    );
  }
}
