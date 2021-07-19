import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/widgets/card/card.dart';
import 'package:jtech_common_library/widgets/image/clip.dart';
import 'package:jtech_common_library/widgets/image/config.dart';
import 'package:jtech_common_library/widgets/image/jimage.dart';

/*
* 卡片组件demo
* @author wuxubaiyang
* @Time 2021/7/19 下午3:21
*/
class CardDemo extends BasePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卡片demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Text("常规单元素组件"),
            JCard.single(
              child: JImage.net(
                "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                size: 200,
                fit: BoxFit.cover,
                config: ImageConfig(
                    clip:
                        ImageClipRRect(borderRadius: BorderRadius.circular(8))),
              ),
            ),
            Divider(),
            Divider(),
            Text("圆形单元素组件"),
            JCard.single(
              child: JImage.net(
                "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                size: 200,
                fit: BoxFit.cover,
                clip: ImageClipOval(),
              ),
              circle: true,
              // padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            Divider(),
            Divider(),
            Text("垂直圆角组件"),
            JCard.column(
              children: [
                JImage.net(
                  "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                  size: 200,
                  fit: BoxFit.cover,
                  clip: ImageClipRRect(borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
                ),
                SizedBox(height: 10),
                JImage.net(
                  "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                  size: 200,
                  fit: BoxFit.cover,
                  clip: ImageClipRRect(borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
                ),
              ],
            ),
            Divider(),
            Divider(),
            Text("水平圆角组件"),
            JCard.row(
              children: [
                JImage.net(
                  "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                  size: 100,
                  fit: BoxFit.cover,
                  clip: ImageClipRRect(borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  )),
                ),
                SizedBox(width: 10),
                JImage.net(
                  "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
                  size: 100,
                  fit: BoxFit.cover,
                  clip: ImageClipRRect(borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
