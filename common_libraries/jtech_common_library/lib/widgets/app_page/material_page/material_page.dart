import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_stateless_widget.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/config.dart';

/*
* material风格的页面根节点
* @author wuxubaiyang
* @Time 2021/7/21 下午2:36
*/
class MaterialRootPage extends BaseStatelessWidget {
  //标题组件
  final PreferredSizeWidget? appBar;

  //页面内容元素
  final Widget body;

  //配置文件
  final MaterialRootPageConfig config;

  MaterialRootPage({
    required String appBarTitle,
    required this.body,
    this.appBar,
    Widget? appBarLeading,
    List<Widget>? appBarActions,
    Color? backgroundColor,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    MaterialRootPageConfig? config,
    Widget? bottomNavigationBar,
  }) : this.config = (config ?? MaterialRootPageConfig()).copyWith(
          appBarTitle: appBarTitle,
          appBarLeading: appBarLeading,
          appBarActions: appBarActions,
          backgroundColor: backgroundColor,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          bottomNavigationBar: bottomNavigationBar,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAPPBar(),
      body: body,
      backgroundColor: config.backgroundColor,
      bottomNavigationBar: config.bottomNavigationBar,
      floatingActionButton: config.floatingActionButton,
      floatingActionButtonLocation: config.floatingActionButtonLocation,
      floatingActionButtonAnimator: config.floatingActionButtonAnimator,
    );
  }

  //构造appbar
  PreferredSizeWidget _buildAPPBar() {
    if (null != appBar) return appBar!;
    return AppBar(
      leading: config.appBarLeading,
      title: Text(config.appBarTitle),
      actions: config.appBarActions,
    );
  }
}
