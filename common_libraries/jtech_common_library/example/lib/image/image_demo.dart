import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/base/empty_box.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* 图片demo
* @author wuxubaiyang
* @Time 2021/7/13 上午11:13
*/
class ImageDemo extends BasePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JImage.file(),
            JImage.assets(),
            JImage.memory(),
            JImage.net(),
          ],
        ),
      ),
    );
  }
}
