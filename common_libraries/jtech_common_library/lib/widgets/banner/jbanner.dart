import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateful_widget.dart';

/*
* banner组件
* @author wuxubaiyang
* @Time 2021/7/13 下午4:45
*/
class JBanner extends BaseStatefulWidget {
  //基础构造方法
  JBanner.create();

  final PageController controller = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      var index = controller.page;
      if (index == 0) {
        controller.jumpToPage(items.length);
      } else if (index == items.length + 2 - 1) {
        controller.jumpToPage(1);
      }
    });
  }

  final List<String> items = [
    "1",
    "2",
    "3",
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(15),
        child: PageView.builder(
          controller: controller,
          itemCount: items.length + 2,
          itemBuilder: (context, index) {
            var item;
            if (index == 0) item = items.last;
            if (index == (items.length + 2) - 1) item = items.first;
            item ??= items[index - 1];
            return Text(
              "$item",
              style: TextStyle(
                fontSize: 30,
              ),
            );
          },
        ),
      ),
    );
  }
}
