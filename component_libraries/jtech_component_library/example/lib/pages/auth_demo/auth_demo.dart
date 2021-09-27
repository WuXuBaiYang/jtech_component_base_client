import 'package:example/pages/auth_demo/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_component_library/jcomponent.dart';

/*
* 授权模块测试demo
* @author wuxubaiyang
* @Time 2021/9/26 16:28
*/
class AuthDemoPage extends BaseStatelessPage {
  //功能列表
  final Map<String, Function> functionMap = {
    "判断是否已登录": (context) {
      jSnack.showSnackInTime(context,
          text: "当前状态：${jAuth.isLogin() ? "已登录" : "未登录"}");
    },
    "获取所有登录信息": (context) {
      jSheet.showBottomSheet(context, builder: (_) {
        var authList = jAuth.getAuthList();
        if (authList.isEmpty) {
          return Material(
            child: Container(
              width: double.maxFinite,
              color: Colors.white,
              padding: EdgeInsets.all(25),
              child: Text("无数据"),
            ),
          );
        }
        return Material(
          child: Container(
            color: Colors.white,
            child: JListView.def<AuthModel>(
              itemBuilder: (_, item, __) {
                return ListTile(
                  title: Text("KEY：${item.key}"),
                  subtitle: Text("TOKEN：${item.token}"),
                  trailing: Text("${item.active ? "已登录" : "未登录"}"),
                );
              },
              controller: JListViewController(
                dataList: authList,
              ),
            ),
          ),
        );
      });
    },
    "生成一条登录信息": (context) async {
      var auth = AuthModel(token: "token_${jTools.generateID()}");
      var result = await jAuth.login(
        auth,
        extData: LoginUserModel("jj_${DateTime.now().microsecond}", 18, "male"),
      );
      jSnack.showSnackInTime(context,
          text: result ? "已添加登录信息：${auth.key}" : "登录失败！");
    },
    "将列表中第一个非登录状态重新登录": (context) async {
      var authList = jAuth.getAuthList();
      var unLoginAuth;
      for (var item in authList) {
        if (!item.active) {
          unLoginAuth = item;
          break;
        }
      }
      if (null == unLoginAuth)
        return jSnack.showSnackInTime(context, text: "无可用信息");
      var result = await jAuth.login(unLoginAuth);
      jSnack.showSnackInTime(context, text: result ? "登录成功" : "登录失败");
    },
    "注销登录信息不删除信息": (context) async {
      if (!jAuth.isLogin()) {
        return jSnack.showSnackInTime(context, text: "未登录无法退出");
      }
      var result = await jAuth.logout(delete: false);
      jSnack.showSnackInTime(context, text: result ? "注销成功" : "注销失败");
    },
    "注销登录信息并删除": (context) async {
      if (!jAuth.isLogin()) {
        return jSnack.showSnackInTime(context, text: "未登录无法退出");
      }
      var result = await jAuth.logout();
      jSnack.showSnackInTime(context, text: result ? "注销成功" : "注销失败");
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "授权功能模块",
      body: JListView.def<String>(
          itemBuilder: (_, item, index) {
            return ListTile(
              title: Text(item),
              onTap: () => functionMap[item]!(context),
            );
          },
          controller: JListViewController(
            dataList: functionMap.keys.toList(),
          )),
    );
  }
}
