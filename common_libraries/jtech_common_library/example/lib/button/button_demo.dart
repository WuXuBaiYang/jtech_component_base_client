import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 按钮组件demo
* @author jtechjh
* @Time 2021/8/16 2:44 下午
*/
class ButtonDemo extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "按钮组件demo",
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: JPopupButton.icon<String>(context,
                  icon: Icon(Icons.add),
                  builder: (_, dismiss) {
                    return InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.red,
                        width: 70,
                        height: 100,
                      ),
                      onTap: () => dismiss("success"),
                    );
                  },
                  size: Size(70, 100),
                  onPopupDismiss: (result) {
                    print("");
                  }),
              title: Text("自定义弹层测试"),
            ),
          ],
        ),
      ),
    );
  }
}
