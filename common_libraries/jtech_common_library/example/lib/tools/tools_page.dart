import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:jtech_common_library/widgets/app_page/material_page/material_page.dart';
import 'package:jtech_common_library/widgets/listview/base/controller.dart';
import 'package:jtech_common_library/widgets/listview/listview.dart';

/*
* 工具demo页面
* @author wuxubaiyang
* @Time 2021/7/23 下午4:42
*/
class ToolsDemo extends BasePage {
  //管理折叠组件状态
  final ListValueChangeNotifier<bool> expandStatus =
      ListValueChangeNotifier.empty();

  //工具折叠列表
  final List<Map<String, Function>> toolList = [
    //日期格式化工具表
    {
      "全中文日期时间格式化": () {
        return jCommon.tools.dataFormat.formatFullDateTimeZH(DateTime.now());
      },
      "中文日期时间格式化": () {
        return jCommon.tools.dataFormat.formatDateTimeZH(DateTime.now());
      },
      "全中文日期格式化": () {
        return jCommon.tools.dataFormat.formatFullDateZH(DateTime.now());
      },
      "中文日期格式化": () {
        return jCommon.tools.dataFormat.formatDateZH(DateTime.now());
      },
      "全中文时间格式化": () {
        return jCommon.tools.dataFormat.formatFullTimeZH(DateTime.now());
      },
      "中文时间格式化": () {
        return jCommon.tools.dataFormat.formatTimeZH(DateTime.now());
      },
      "全日期时间格式化": () {
        return jCommon.tools.dataFormat.formatFullDateTime(DateTime.now());
      },
      "日期时间格式化": () {
        return jCommon.tools.dataFormat.formatDateTime(DateTime.now());
      },
      "全日期格式化": () {
        return jCommon.tools.dataFormat.formatFullDate(DateTime.now());
      },
      "日期格式化": () {
        return jCommon.tools.dataFormat.formatDate(DateTime.now());
      },
      "全时间格式化": () {
        return jCommon.tools.dataFormat.formatFullTime(DateTime.now());
      },
      "时间格式化": () {
        return jCommon.tools.dataFormat.formatTime(DateTime.now());
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    //遍历折叠工具集合，设置初始值
    expandStatus.setValue(toolList.map<bool>((e) => false).toList());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      appBarTitle: "工具测试类",
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
                    return ListTile(title: Text("日期格式化集合"));
                  },
                  body: JListView<String>(
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
                            text: result,
                            duration: Duration(milliseconds: 600));
                      },
                    ),
                  ),
                );
              }),
              expansionCallback: (index, expand) {
                expandStatus.putValue(index, !expand);
              },
            );
          },
        ),
      ),
    );
  }
}
