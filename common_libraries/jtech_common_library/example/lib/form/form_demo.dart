import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/form/controller.dart';
import 'package:jtech_common_library/widgets/form/form.dart';
import 'package:jtech_common_library/widgets/form/items/form_custom_item.dart';
import 'package:jtech_common_library/widgets/form/items/form_input_item/form_input_item.dart';
import 'package:jtech_common_library/widgets/form/items/form_input_item/formatters.dart';
import 'package:jtech_common_library/widgets/form/items/form_switch_item.dart';
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
      appBarActions: [
        IconButton(
          icon: Icon(Icons.done_all),
          onPressed: () => controller.submit(),
        ),
      ],
      body: JFormView(
        controller: controller,
        children: [
          JFormTextItem(
            enabled: true,
            title: Text("文本-标题"),
            text: '测试表单子项',
            isArrow: true,
            onTap: (value) {
              jCommon.popups.snack
                  .showSnackInTime(context, text: "文本form项，点击事件");
            },
            onLongTap: (value) {
              jCommon.popups.snack
                  .showSnackInTime(context, text: "文本form项，长点击事件");
            },
          ),
          JFormCustomItem<Map<String, String>>(
            enabled: true,
            title: Text("自定义-标题"),
            isArrow: true,
            initialValue: {
              "title": "这里是自定义标题",
            },
            onTap: (value) {
              jCommon.popups.snack
                  .showSnackInTime(context, text: "自定义form项，点击事件");
            },
            onLongTap: (value) {
              jCommon.popups.snack
                  .showSnackInTime(context, text: "自定义form项，长点击事件");
            },
            builder: (field) {
              return Text.rich(
                TextSpan(
                  text: field.value!["title"],
                  children: [
                    TextSpan(
                        text: "红色",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        )),
                  ],
                ),
              );
            },
          ),
          JFormInputItem(
            title: Text("输入框-标题"),
            isArrow: true,
            maxLength: 10,
            // readOnly: true,
            textAlign: TextAlign.end,
            inputFormatters: [
              JInputFormatters.decimalsOnly,
            ],
            obscureText: true,
            showClearButton: true,
            onSaved: (v) {
              print("");
            },
            // onTap: (v){},
          ),
          JFormSwitchItem(
            title: Text("开关-标题"),
            initialValue: true,
            isArrow: true,
            clickFullArea: true,
            onTap: (value){
              print("");
            },
          ),
        ],
        dividerBuilder: (_, index) => Divider(indent: 15),
      ),
    );
  }
}
