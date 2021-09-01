import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 管理工具方法
* @author jtechjh
* @Time 2021/8/31 4:11 下午
*/
class ManageDemo extends BaseStatelessPage {
  //管理折叠组件状态
  final ListValueChangeNotifier<bool> expandStatus;

  //标题
  static final List<String> toolsTitleList = [
    "缓存管理",
    "网络管理",
    "通知管理",
  ];

  //折叠列表
  static final List<Map<String, Function>> toolList = [
    //缓存管理
    {
      "写入所有类型参数": () {
        jCache.setString("string_key", "字符串字段");
        jCache.setStringList("string_list_key", ["str1"]);
        jCache.setDouble("double_key", 1.0);
        jCache.setInt("ink_key", 1);
        jCache.setBool("bool_key", true);
        jCache.setJsonList("json_list_key", [
          {"name": "张"},
          {"name": "李"}
        ]);
        jCache.setJsonMap("json_map_key", {
          "name": "张",
          "sex": 0,
        });
        return "已写入";
      },
      "读取所有类型参数": () {
        var a = jCache.getString("string_key", def: "");
        var b = jCache.getStringList("string_list_key", def: []);
        var c = jCache.getDouble("double_key", def: 0.0);
        var d = jCache.getInt("ink_key", def: 0);
        var e = jCache.getBool("bool_key", def: true);
        var f = jCache.getJson("json_list_key", def: []);
        var g = jCache.getJson("json_map_key", def: {});
        return "已读取:\n$a\n$b\n$c\n$d\n$e\n$f\n$g";
      },
      "写入5秒有效期参数": () {
        jCache.setString(
          "string_key_e",
          "只有5秒钟时限",
          expiration: Duration(seconds: 5),
        );
        return "已写入";
      },
      "读取5秒有效期参数": () {
        return "已读取参数：${jCache.getString("string_key_e")}";
      },
      "清除字符串类型参数": () {
        jCache.remove("string_key");
        return "已清除";
      },
      "清除所有参数": () {
        jCache.removeAll();
        return "已清除";
      },
    },
    //网络管理
    {
      "匹配手机号(+86) 18600000000": () {
        return jCommon.tools.matches.hasPhoneNumber_86("18600000000");
      }
    },
    //通知管理
    {
      "弹出简易通知": () {
        jNotification.showSimple(
          title: "简易通知标题",
          body: "简易通知消息体",
          id: 0,
        );
        return "已弹出简易通知";
      },
      "取消简易通知": () {
        jNotification.cancel(0);
        return "已取消简易通知";
      },
      "弹出进度提示(点击增加进度切换状态)": () {
        progress += 10;
        if (progress >= 100) progress = -1;
        jNotification.showProgress(
          title: "带有进度条的通知,点击增加",
          id: 1,
          maxProgress: 100,
          indeterminate: progress == -1,
          progress: progress,
        );
        return "已切换进度状态";
      },
      "取消进度条通知": () {
        jNotification.cancel(1);
        return "已取消进度通知";
      },
    },
  ];

  //记录进度
  static int progress = -1;

  ManageDemo()
      : this.expandStatus =
            ListValueChangeNotifier(toolList.map<bool>((e) => false).toList());

  @override
  Widget build(BuildContext context) {
    return MaterialPageRoot(
      appBarTitle: "管理工具类",
      body: SingleChildScrollView(
        child: ValueListenableBuilder<List<bool>>(
          valueListenable: expandStatus,
          builder: (context, statusList, child) {
            return ExpansionPanelList(
              children: List.generate(toolList.length, (index) {
                var tools = toolList[index];
                return ExpansionPanel(
                  isExpanded: statusList[index],
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpand) {
                    return ListTile(title: Text(toolsTitleList[index]));
                  },
                  body: JListView.def<String>(
                    canScroll: false,
                    controller: JListViewController(
                      dataList: tools.keys.toList(),
                    ),
                    dividerBuilder: (context, index) => Divider(),
                    itemBuilder: (context, item, index) => ListTile(
                      title: Text(item),
                      onTap: () {
                        var result = tools[item]!();
                        if (null != result) {
                          jCommon.popups.snack.showSnackInTime(context,
                              text: "$result",
                              duration: Duration(milliseconds: 600));
                        }
                      },
                    ),
                  ),
                );
              }),
              expansionCallback: (index, expand) =>
                  expandStatus.putValue(index, !expand),
            );
          },
        ),
      ),
    );
  }
}
