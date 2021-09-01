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
        return "已写入";
      },
      "读取所有类型参数": () {
        return "已读取";
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
        return jNotificationManage.showSimple(title: "简易通知标题");
      }
    },
  ];

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
                        jCommon.popups.snack.showSnackInTime(context,
                            text: "$result",
                            duration: Duration(milliseconds: 600));
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
