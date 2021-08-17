import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:path_provider/path_provider.dart';

/*
* 图片demo
* @author wuxubaiyang
* @Time 2021/7/13 上午11:13
*/
class ImageDemo extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "图片demo",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Text("本地图片加载"),
            Divider(),
            FutureBuilder<File>(
              future: Future.value(Future.sync(() async {
                Directory directory = await getApplicationDocumentsDirectory();
                var imageFile =
                    File(join(directory.path, "test_file_image.jpeg"));
                if (!imageFile.existsSync()) {
                  ByteData data =
                      await rootBundle.load("assets/test_file_image.jpeg");
                  List<int> bytes = data.buffer
                      .asUint8List(data.offsetInBytes, data.lengthInBytes);
                  await imageFile.writeAsBytes(bytes);
                }
                return imageFile;
              })),
              builder: (_, snap) {
                if (!snap.hasData) return Container();
                return JImage.file(
                  snap.data!,
                  size: 200,
                  fit: BoxFit.cover,
                  clip: ImageClipOval(),
                  config: ImageConfig(),
                  imageTap: () {
                    jCommon.popups.snack.showSnackInTime(context, text: "点击");
                  },
                  imageLongTap: () {
                    jCommon.popups.snack.showSnackInTime(context, text: "长点击");
                  },
                );
              },
            ),
            Divider(),
            Text("assets资源文件加载"),
            Divider(),
            JImage.assets(
              "assets/test_image.jpg",
              size: 200,
              fit: BoxFit.cover,
              clip: ImageClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Divider(),
            Text("内存文件加载"),
            Divider(),
            FutureBuilder<Uint8List>(
              future: Future.value(Future.sync(() async =>
                  (await rootBundle.load("assets/test_memory_image.jpeg"))
                      .buffer
                      .asUint8List())),
              builder: (_, snap) {
                if (!snap.hasData) return Container();
                return JImage.memory(
                  snap.data!,
                  size: 200,
                  fit: BoxFit.cover,
                );
              },
            ),
            Divider(),
            Text("网络图片加载"),
            Divider(),
            JImage.net(
              "https://img.zcool.cn/community/0173035e553071a801216518fc442f.jpg@1280w_1l_2o_100sh.jpg",
              size: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  //加载assets中的图片并输出Uint8List
  Future<Uint8List>? loadMemoryImage() async {
    return (await rootBundle.load("assets/test_memory.jpg"))
        .buffer
        .asUint8List();
  }
}
