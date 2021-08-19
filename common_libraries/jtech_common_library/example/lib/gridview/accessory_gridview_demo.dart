import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 附件表格组件demo
* @author wuxubaiyang
* @Time 2021/7/20 下午2:49
*/
class AccessoryGridviewDemo extends BaseStatelessPage {
  AccessoryGridviewDemo();

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "附件表格组件",
      body: JGridView.accessory(
        menuItems: [
          PickerMenuItem.image(),
          PickerMenuItem.video(),
        ],
      ),
    );
  }
}
