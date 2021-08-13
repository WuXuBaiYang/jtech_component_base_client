import 'package:flutter/cupertino.dart';

/*
* 路由管理类
* @author jtechjh
* @Time 2021/8/13 9:02 上午
*/
class JRouter {
  static final JRouter _instance = JRouter._internal();

  factory JRouter() => _instance;

  JRouter._internal();

  //全局路由key
  final GlobalKey<NavigatorState> navigateKey =
      GlobalKey(debugLabel: 'jrouter_navigate_key');

  //获取路由对象
  NavigatorState? get navigator => navigateKey.currentState;

  //初始化方法
  Future init() async {}

  //页面跳转
  Future<T?>? push<T>(String url) {
    var uri = Uri.parse(url);
    return navigator?.pushNamed<T>(
      uri.path,
      arguments: uri.queryParameters,
    );
  }

  //跳转页面并一直退出到目标页面
  Future<T?>? pushAndRemoveUntil<T>(String url, {required untilPath}) {
    var uri = Uri.parse(url);
    return navigator?.pushNamedAndRemoveUntil<T>(
      uri.path,
      ModalRoute.withName(untilPath),
      arguments: uri.queryParameters,
    );
  }

  //跳转并替换当前页面
  Future<T?>? pushReplacement<T, TO>(String url, {TO? result}) {
    var uri = Uri.parse(url);
    return navigator?.pushReplacementNamed<T, TO>(
      uri.path,
      result: result,
      arguments: uri.queryParameters,
    );
  }

  //退出当前页面并跳转目标页面
  Future<T?>? popAndPush<T, TO>(String url, {TO? result}) {
    var uri = Uri.parse(url);
    return navigator?.popAndPushNamed<T, TO>(
      uri.path,
      result: result,
      arguments: uri.queryParameters,
    );
  }

  //页面退出
  Future<bool>? maybePop<T>([T? result]) => navigator?.maybePop<T>(result);

  //页面退出
  void pop<T>([T? result]) => navigator?.pop<T>(result);

  //判断页面是否可退出
  bool? canPop() => navigator?.canPop();

  //页面连续退出
  void popUntil({required untilPath}) => navigator?.popUntil(
        ModalRoute.withName(untilPath),
      );
}

//单例调用
final jRouter = JRouter();