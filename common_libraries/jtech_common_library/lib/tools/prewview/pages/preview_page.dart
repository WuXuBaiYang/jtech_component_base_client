import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 预览页面基类
* @author jtechjh
* @Time 2021/8/23 10:38 上午
*/
abstract class BasePreviewPage extends StatelessWidget {
  //预览页面配置对象
  final PreviewConfig config;

  //标题页码计数器
  final ValueChangeNotifier<int> counter;

  BasePreviewPage({
    Key? key,
    required this.config,
  })  : this.counter = ValueChangeNotifier(0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBar: _buildAppBar(),
      backgroundColor: config.color,
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
            onTapDown: (_) {
              if (config.barrierDismissible) {
                return jRouter.pop();
              }
            },
          ),
          buildPreviewContent(),
        ],
      ),
    );
  }

  //构建预览部分
  Widget buildPreviewContent();

  //构建标题栏
  PreferredSizeWidget? _buildAppBar() {
    if (!config.showAppbar) return null;
    return AppBar(
      title: ValueListenableBuilder(
        valueListenable: counter,
        builder: (context, value, child) => Text(getTitle()),
      ),
      centerTitle: config.centerTitle,
      backgroundColor: config.appbarColor,
      leading: config.backButton ?? BackButton(),
    );
  }

  //构建标题内容
  String getTitle() {
    if (!config.showCounter) return config.title;
    return "${config.title}(${counter.value}/$totalCount)";
  }

  //更新计数
  void updateCounter(int currentIndex) => counter.setValue(currentIndex);

  //获取预览文件的总数量
  int get totalCount;
}
