import 'package:flutter/material.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 头像组件demo
* @author jtechjh
* @Time 2021/9/4 4:23 下午
*/
class AvatarDemo extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "头像组件demo",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Text("矩形"),
            JAvatar.square(
              size: 65,
              dataSource: ImageDataSource.net(
                  "https://th.bing.com/th/id/OIP.ZTmNathhKflijArYDaQEDAHaEo?w=295&h=184&c=7&r=0&o=5&dpr=2&pid=1.7"),
              pickImage: true,
              elevation: 4,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(8),
              onAvatarUpload: (String filePath) async {
                await Future.delayed(Duration(seconds: 2));
                return JFileInfo.fromPath(filePath);
              },
            ),
            Divider(),
            Divider(),
            Text("圆形"),
            JAvatar.circle(
              size: 65,
              elevation: 4,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(8),
              dataSource: ImageDataSource.net(
                  "https://th.bing.com/th/id/OIP.ZTmNathhKflijArYDaQEDAHaEo?w=295&h=184&c=7&r=0&o=5&dpr=2&pid=1.7"),
              pickImage: true,
              takePhoto: true,
              onAvatarUpload: (String filePath) async {
                await Future.delayed(Duration(seconds: 2));
                return JFileInfo.fromPath(filePath);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
