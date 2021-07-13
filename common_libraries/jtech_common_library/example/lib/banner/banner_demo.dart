
import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/banner/jbanner.dart';

/*
* banner demo
* @author wuxubaiyang
* @Time 2021/7/13 上午11:13
*/
class BannerDemo extends BasePage {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("banner demo"),
      ),
      body: JBanner.create(),
    );
  }
}
