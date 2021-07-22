import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/form/controller.dart';
import 'package:jtech_common_library/widgets/form/form.dart';
import 'package:jtech_common_library/widgets/form/items/form_text_item.dart';

/*
* 表单组件demo页面
* @author wuxubaiyang
* @Time 2021/7/22 下午2:17
*/
class FormDemo extends BasePage {
  //表单控制器
  final JFormController controller = JFormController();

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "form表单demo",
      body: JFormView(
        controller: controller,
        children: [
          JFormTextItem(
            enabled: false,
            title: Text("文本标题"),
            text: '测试表单子项',
            isArrow: true,
            onTap: (value){},
            onLongTap: (value){},
          ),
        ],
        dividerBuilder: (_, index) => Divider(indent: 15),
      ),
    );
  }
}
