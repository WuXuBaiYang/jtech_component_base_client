import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';
import 'package:jtech_common_library/base/empty_box.dart';
import 'package:jtech_common_library/widgets/badge/config.dart';

/*
* 角标视图元素
* @author wuxubaiyang
* @Time 2021/7/12 上午10:29
*/
class JBadgeView extends BaseStatefulWidget {
  //角标配置
  final BadgeConfig config;

  //从配置中加载角标组件
  JBadgeView.create({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config == BadgeConfig.empty) return EmptyBox();
    return SizedBox.fromSize(
      size: Size(config.width, config.height),
      child: Card(
        child: Center(
          child: Padding(
            padding: config.padding,
            child: config.child ?? Text(config.text, style: config.textStyle),
          ),
        ),
        elevation: config.elevation,
        color: config.color,
        shape: config.circle
            ? CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(config.radius),
                ),
              ),
      ),
    );
  }
}
