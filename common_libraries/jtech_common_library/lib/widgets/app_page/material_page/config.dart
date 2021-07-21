import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*
* material风格页面基本组件配置
* @author wuxubaiyang
* @Time 2021/7/21 下午4:53
*/
class MaterialRootPageConfig {
  //标题，左侧元素
  final Widget appBarLeading;

  //标题文本
  final String appBarTitle;

  //标题动作元素集合
  final List<Widget> appBarActions;

  //背景色
  final Color backgroundColor;

  //底部导航栏组件
  final Widget? bottomNavigationBar;

  //fab按钮组件
  final Widget? floatingActionButton;

  //fab按钮位置
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  //fab按钮动画
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  MaterialRootPageConfig({
    String? appBarTitle,
    Widget? appBarLeading,
    List<Widget>? appBarActions,
    Color? backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  })  : this.appBarTitle = appBarTitle ?? '',
        this.appBarLeading = appBarLeading ?? BackButton(),
        this.appBarActions = appBarActions ?? [],
        this.backgroundColor = backgroundColor ?? Colors.grey[200]!;

  MaterialRootPageConfig copyWith({
    String? appBarTitle,
    Widget? appBarLeading,
    List<Widget>? appBarActions,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
  }) {
    return MaterialRootPageConfig(
      appBarTitle: appBarTitle ?? this.appBarTitle,
      appBarLeading: appBarLeading ?? this.appBarLeading,
      appBarActions: appBarActions ?? this.appBarActions,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomNavigationBar: bottomNavigationBar ?? this.bottomNavigationBar,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation ?? this.floatingActionButtonLocation,
      floatingActionButtonAnimator:
          floatingActionButtonAnimator ?? this.floatingActionButtonAnimator,
    );
  }
}
