import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* banner demo
* @author wuxubaiyang
* @Time 2021/7/13 上午11:13
*/
class BannerDemo extends BaseStatelessPage {
  //banner控制器
  final JBannerController controller = JBannerController(
    initialIndex: 0,
    items: [
      BannerItem(
        builder: (context) {
          return JImage.net(
            "https://tse2-mm.cn.bing.net/th/id/OIP-C.xsA-3qUw6cqmd8nRfxk6TQHaEK?w=317&h=180&c=7&o=5&pid=1.7",
            fit: BoxFit.cover,
          );
        },
        title: Text("第一页title测试"),
      ),
      BannerItem(
        builder: (context) {
          return JImage.net(
            "https://tse4-mm.cn.bing.net/th/id/OIP-C.PTZJ51e7xutqxF_1nXpdawHaEK?w=317&h=180&c=7&o=5&pid=1.7",
            fit: BoxFit.cover,
          );
        },
        title: Text("第二页title测试"),
      ),
      BannerItem(
        builder: (BuildContext context) {
          return JImage.net(
            "https://tse2-mm.cn.bing.net/th/id/OIP-C.3m1ogEZilvIW8HK-Ry0MbgHaFj?w=233&h=180&c=7&o=5&pid=1.7",
            fit: BoxFit.cover,
          );
        },
        title: Text("第三页title测试"),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "banner demo",
      appBarActions: [
        IconButton(
          icon: Text("跳转最后一页"),
          onPressed: () {
            controller.select(2);
          },
        ),
      ],
      body: JBanner(
        controller: controller,
        showTitle: true,
        indicatorAlign: BannerAlign.right,
        infinity: true,
        height: 230,
        margin: EdgeInsets.all(15),
        elevation: 8,
        padding: EdgeInsets.all(2),
        borderRadius: BorderRadius.circular(8),
        auto: true,
        itemTap: (item, index) {
          jCommon.popups.snack
              .showSnackInTime(context, text: "第 $index 条数据点击事件");
        },
        itemLongTap: (item, index) {
          jCommon.popups.snack
              .showSnackInTime(context, text: "第 $index 条数据长点击事件");
        },
      ),
    );
  }
}
